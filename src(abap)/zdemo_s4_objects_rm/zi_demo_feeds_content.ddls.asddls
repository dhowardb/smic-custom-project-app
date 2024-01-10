@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Feeds Content'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_FEEDS_CONTENT
  as select from zdt_demo_feeds
  association to parent ZI_DEMO_S4_PROJECT_INTERFACE as _Projects on $projection.ProjectUuid = _Projects.ProjectUUID
  association to ZI_DEMO_USERS as _Users on $projection.CreatedBy = _Users.UserName
{
  key feed_content_uuid     as FeedContentUuid,
  key project_uuid          as ProjectUuid,
      _Users.FullName       as Sender,
//      sender                as Sender,
      info                  as Info,
      content               as Content,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      /*Association*/
      _Projects
}
