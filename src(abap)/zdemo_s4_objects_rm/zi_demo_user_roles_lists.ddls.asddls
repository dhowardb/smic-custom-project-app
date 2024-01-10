@EndUserText.label: 'Demo for lists of user roles'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
define view entity ZI_DEMO_USER_ROLES_LISTS
  as select from zdt_demo_roles
{
  @EndUserText.label: 'Username'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @ObjectModel.text.element: ['RoleName']
  key role_name   as RoleName,
  @EndUserText.label: 'Role Description'
      description as Description
}
