@EndUserText.label: 'Projection View for Users Assigned'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_DEMO_USERS_ASSIGNED
  as projection on ZI_DEMO_USERS_ASSIGNED
{
  key UsersAssignedUuid,
  key ProjectUuid,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_USERS', element: 'UserName' } }]
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['Fullname']
      UsersAssigned,
      Fullname,
      EmailAddress,
      UserRole,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Projects : redirected to parent ZC_DEMO_S4_PROJECT_INTERFACE
}
