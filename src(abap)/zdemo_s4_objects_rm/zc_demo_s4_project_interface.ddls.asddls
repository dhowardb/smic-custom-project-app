@EndUserText.label: 'Projection View for S4 projects'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@ObjectModel.semanticKey: ['ProjectName']
@Metadata.allowExtensions: true
define root view entity ZC_DEMO_S4_PROJECT_INTERFACE
  provider contract transactional_query
  as projection on ZI_DEMO_S4_PROJECT_INTERFACE
{
  key ProjectUUID,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      ProjectName,
      @Search.fuzzinessThreshold: 0.7
      EccTcode,
      @Consumption: { valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_TCODES', element: 'transactionCode' } }] }
      @Search.defaultSearchElement: true
      S4Tcode,
      @Consumption: { valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_SYSTEMS', element: 'Zsystem' } }] }
      @Search.defaultSearchElement: true
      SystemSource,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_USERS', element: 'UserName' } }]
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['_Users.FullName']
      RemediatedBy,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_USERS', element: 'UserName' } }]
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['_Users.FullName']
      @UI.textArrangement: #TEXT_ONLY
      WorkstreamLead,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_USERS', element: 'UserName' } }]
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['_Users.FullName']
      DeveloperAssigned,
      UsersAssigned,
      DevelopersAssigned,
      FunctionalsAssigned,
      @Consumption: { valueHelpDefinition: [{ entity: { name: 'ZCVH_DEMO_ITGROUP', element: 'ItGroup' } }] }
      ITGroupAssigned,
      ProjectSponsor,
      ProcessOwner,
      RequestorCompany,
      RequestorDepartment,
      AffectedPlatforms,
      CharmNumber,
      WorkItem,
      ObjectiveOrPurpose,
      ProjectType,
      Classification,
      Phase,
      EffortSavedOrBenefit,
      AdditionalDetail,
      AdditionalDetail_2,
      Complexity,
      StartDate,
      ProjectedDate,
      CompletionDate,
      ProjectDuration,
      ProjectTotalDuration,
      ProjectDurationCriticality,
      @Consumption: { valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_STATUS', element: 'Status' } }] }
      @ObjectModel.text.element: ['StatusDescription']
      TestStatus,
      StatusDescription,
      StatusCriticality,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_PRIORITY', element: 'Value' } }]
      @ObjectModel.text.element: ['PriorityDescription']
      @UI.textArrangement: #TEXT_ONLY
      Priority,
      PriorityDescription,
      PriorityCriticality,
      ProjectedWorkHours,
      TotalWorkHours,
      WorkLogChartValue,
      WorkLogCriticality,
      ProgressIndicator,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_USERS', element: 'UserName' } }]
      @ObjectModel.text.element: ['_Users.FullName']
      CreatedBy,
      CreatedAt,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_USERS', element: 'UserName' } }]
      @ObjectModel.text.element: ['_Users.FullName']
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /*Associations*/
      _Objects      : redirected to composition child ZC_DEMO_S4_OBJECTS,
      _Systems,
      _Status,
      _Priority,
      _Users,
      _Tcodes,
      _Worklogs     : redirected to composition child ZC_DEMO_WORKLOG,
      _Charms       : redirected to composition child ZC_DEMO_CHARM,
      _Feeds        : redirected to composition child ZC_DEMO_FEEDS_CONTENT,
      _UserAssigned : redirected to composition child ZC_DEMO_USERS_ASSIGNED,
      _Actions      : redirected to composition child ZC_DEMO_ACTIONS

}
