@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for users'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_DEMO_USERS
  as select from    usr21 as UserInfo
    left outer join adrp  as PersonInfo on UserInfo.persnumber = PersonInfo.persnumber
    left outer join adr6  as EmailInfo  on UserInfo.persnumber = EmailInfo.persnumber
  association [0..1] to zi_demo_user_roles as _UserWithRoles on $projection.UserName = _UserWithRoles.Username
  //  association [1..1] to adrp on UserInfo.persnumber = adrp.persnumber
  //  association [1..1] to adr6 on UserInfo.persnumber = adr6.persnumber
{
      @EndUserText.label: 'Username'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @ObjectModel.text.element: ['FullName']
  key UserInfo.bname                                                    as UserName,
      @UI.hidden: true
      UserInfo.persnumber                                               as PersonNumber,
      @UI.hidden: true
      UserInfo.addrnumber                                               as AddressNumber,
      @EndUserText.label: 'First Name'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      PersonInfo.name_first                                             as FirstName,
      @EndUserText.label: 'Last Name'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.fulltextIndex.required: true
      PersonInfo.name_last                                              as LastName,
      @EndUserText.label: 'Full Name'
      concat_with_space(PersonInfo.name_first, PersonInfo.name_last, 1) as FullName,
      @EndUserText.label: 'Email Address'
      @Search.fuzzinessThreshold: 0.7
      EmailInfo.smtp_addr                                               as EmailAddress,

      //demo to be replaced by a maintenance CDS or entity
      //      case when UserInfo.bname = 'SMIC.DHB'
      //             or UserInfo.bname = 'SMIC.BAT'
      //           then 'Developer'
      //           when UserInfo.bname = 'FISG.ARC'
      //             or UserInfo.bname = 'FISG.MCG'
      //           then 'Functional'
      //           else 'Unknown'
      //                                         end                            as UserRole
      case when _UserWithRoles.Role is not initial
            then _UserWithRoles.Role
            else 'No Role Maintained' end                               as UserRole
}
where
  UserInfo.persnumber is not initial
