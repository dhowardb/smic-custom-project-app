@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view Users assign per project'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_USERS_ASSIGNED
  as select from zdt_demo_usrass as UserAssigned
    inner join   ZI_DEMO_USERS   as Users on Users.UserName = UserAssigned.users_assigned
  association        to parent ZI_DEMO_S4_PROJECT_INTERFACE as _Projects      on $projection.ProjectUuid = _Projects.ProjectUUID
  association [0..1] to zi_demo_user_roles                  as _UserWithRoles on $projection.UsersAssigned = _UserWithRoles.Username
{
  key UserAssigned.usersassigned_uuid    as UsersAssignedUuid,
  key UserAssigned.project_uuid          as ProjectUuid,
      UserAssigned.users_assigned        as UsersAssigned,
      Users.FullName                     as Fullname,
      Users.EmailAddress                 as EmailAddress,

      //demo to be replaced by a maintenance CDS or entity
      //      case when UserAssigned.users_assigned = 'SMIC.DHB'
      //             or UserAssigned.users_assigned = 'SMIC.BAT'
      //           then 'Developer'
      //           when UserAssigned.users_assigned = 'FISG.ARC'
      //             or UserAssigned.users_assigned = 'FISG.MCG'
      //           then 'Functional'
      //           else 'Unknown'
      //                                         end as UserRole,

      case when _UserWithRoles.Role is not initial
           then _UserWithRoles.Role
           else 'No Role Maintained' end as UserRole,

      @Semantics.user.createdBy: true
      UserAssigned.created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      UserAssigned.created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      UserAssigned.last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      UserAssigned.last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      UserAssigned.local_last_changed_at as LocalLastChangedAt,

      _Projects,
      _UserWithRoles
}
