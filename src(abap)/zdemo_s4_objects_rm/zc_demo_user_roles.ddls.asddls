@EndUserText.label: 'Projection view for Demo User Roles'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['Username'] 
define root view entity ZC_DEMO_USER_ROLES
  provider contract transactional_query
  as projection on zi_demo_user_roles
{
  key UserNameRoleUuid,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_USERS', element: 'UserName' } }]
      Username, 
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_USER_ROLES_LISTS', element: 'RoleName' } }]
      Role,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt
}
