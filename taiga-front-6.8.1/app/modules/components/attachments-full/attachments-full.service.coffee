###
# This source code is licensed under the terms of the
# GNU Affero General Public License found in the LICENSE file in
# the root directory of this source tree.
#
# Copyright (c) 2021-present Kaleidos INC
###

class AttachmentsFullService extends taiga.Service
    @.$inject = [
        "tgAttachmentsService",
        "$rootScope",
        "$q"
    ]

    constructor: (@attachmentsService, @rootScope, @q) ->
        @._attachments = Immutable.List()
        @._deprecatedsCount = 0
        @._attachmentsVisible = Immutable.List()
        @._deprecatedsVisible = false
        @.uploadingAttachments = []
        @.types = @attachmentsService.types
        @.sortType = "DESC"

        taiga.defineImmutableProperty @, 'attachments', () => return @._attachments
        taiga.defineImmutableProperty @, 'deprecatedsCount', () => return @._deprecatedsCount
        taiga.defineImmutableProperty @, 'attachmentsVisible', () => return @._attachmentsVisible
        taiga.defineImmutableProperty @, 'deprecatedsVisible', () => return @._deprecatedsVisible

    toggleDeprecatedsVisible: () ->
        @._deprecatedsVisible = !@._deprecatedsVisible
        @.regenerate()

    regenerate: () ->
        @._deprecatedsCount = @._attachments.count (it) -> it.getIn(['file', 'is_deprecated'])

        if @._deprecatedsVisible
            @._attachmentsVisible = @._attachments
        else
            @._attachmentsVisible = @._attachments.filter (it) -> !it.getIn(['file', 'is_deprecated'])

    addAttachment: (projectId, objId, type, file, editable = false, comment = false) ->
        
        return @q (resolve, reject) =>
            if @attachmentsService.validate(file)
                @.uploadingAttachments.push(file)

                promise = @attachmentsService.upload(file, objId, projectId, type, comment)
                promise.then (file) =>
                    @.uploadingAttachments = @.uploadingAttachments.filter (uploading) ->
                        return uploading.name != file.get('name')

                    attachment = Immutable.Map()

                    attachment = attachment.merge({
                        file: file,
                        editable: editable,
                        loading: false,
                        from_comment: comment
                    })

                    @._attachments = @._attachments.unshift(attachment)

                    @.regenerate()

                    @rootScope.$broadcast("attachment:create")

                    resolve(attachment)
                    @.setSortType(@.sortType)
            else
                reject(new Error(file))

    loadAttachments: (type, objId, projectId)->
        @attachmentsService.list(type, objId, projectId).then (files) =>

            @._attachments = files.map (file) ->
                attachment = Immutable.Map()

                return attachment.merge({
                    loading: false,
                    editable: false,
                    file: file
                })

            @rootScope.$broadcast("attachments:loaded", @._attachments)

            @.regenerate()

    deleteAttachment: (toDeleteAttachment, type) ->
        @.setSortType(@.sortType)
        onSuccess = () =>
            @._attachments = @._attachments.filter (attachment) -> attachment != toDeleteAttachment

            @.regenerate()

        return @attachmentsService.delete(type, toDeleteAttachment.getIn(['file', 'id'])).then(onSuccess)

    reorderAttachment: (objectId, type, attachment, newIndex) ->
        oldIndex = @.attachments.findIndex (it) -> it == attachment

        attachments = @.attachments.remove(oldIndex)
        attachments = attachments.splice(newIndex, 0, attachment)

        attachments = attachments.map (x, i) -> x.setIn(['file', 'order'], i + 1)
        @._attachments = attachments
        @.regenerate()

        afterAttachmentId = null

        if newIndex > 0
            previousAttachment = @.attachments.get(newIndex - 1)
            afterAttachmentId = previousAttachment.getIn(['file', 'id'])

        return @attachmentsService.bulkUpdateOrder(
            objectId,
            type,
            afterAttachmentId,
            [attachment.getIn(['file', 'id'])],
        )

    updateAttachment: (toUpdateAttachment, type) ->
        @.setSortType(@.sortType)
        index = @._attachments.findIndex (attachment) ->
            return attachment.getIn(['file', 'id']) == toUpdateAttachment.getIn(['file', 'id'])

        oldAttachment = @._attachments.get(index)

        patch = taiga.patch(oldAttachment.get('file'), toUpdateAttachment.get('file'))

        if toUpdateAttachment.get('loading')
            @.setAttachments(index, toUpdateAttachment)
        else
            if _.isEmpty(patch)
                @.setAttachments(index, toUpdateAttachment)
            else
                return @attachmentsService.patch(toUpdateAttachment.getIn(['file', 'id']), type, patch).then () =>
                    @.setAttachments(index, toUpdateAttachment)

    setAttachments: (index, toUpdateAttachment) ->
        @._attachments = @._attachments.set(index, toUpdateAttachment)

        @.regenerate()

    setSortType: (sortType) -> 
        @.sortType = sortType

        sortedAttachments = if sortType == "DESC"
            @._attachmentsVisible.sortBy (attachment) -> -new Date(attachment.getIn(['file', 'created_date']))
        else
            @._attachmentsVisible.sortBy (attachment) -> new Date(attachment.getIn(['file', 'created_date']))
        @._attachmentsVisible = sortedAttachments
        

angular.module("taigaComponents").service("tgAttachmentsFullService", AttachmentsFullService)
