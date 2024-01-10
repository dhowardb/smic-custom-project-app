@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo S4 User Roles'
@Search.searchable: true

define root view entity zi_demo_user_roles
  as select from zdt_demo_usrrole
{
  key username_role_uuid    as UserNameRoleUuid,
      @EndUserText.label: 'Username'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      @ObjectModel.text.element: ['Username']
      username              as Username,
      role                  as Role,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
