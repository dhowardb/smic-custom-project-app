@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for S4 Projects BO View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_DEMO_S4_PROJECT_INTERFACE
  as select from    zdt_demo_s4_trm  as Projects
    left outer join ZI_DEMO_PRIORITY as Priority on Projects.priority = Priority.Value
  composition [0..*] of ZI_DEMO_S4_OBJECTS     as _Objects
  composition [0..*] of ZI_DEMO_WORKLOG        as _Worklogs
  composition [0..*] of ZI_DEMO_CHARM          as _Charms
  composition [0..*] of ZI_DEMO_FEEDS_CONTENT  as _Feeds
  composition [0..*] of ZI_DEMO_USERS_ASSIGNED as _UserAssigned
  composition [0..*] of ZI_DEMO_ACTIONS        as _Actions
  association [1..1] to ZI_DEMO_SYSTEMS        as _Systems  on $projection.SystemSource = _Systems.Zsystem
  association [1..1] to ZI_DEMO_STATUS         as _Status   on $projection.TestStatus = _Status.Status
  association [1..1] to ZI_DEMO_PRIORITY       as _Priority on $projection.Priority = _Priority.Value
  association [1..1] to ZI_DEMO_USERS          as _Users    on $projection.CreatedBy = _Users.UserName
  association [1..1] to ZI_DEMO_TCODES         as _Tcodes   on $projection.S4Tcode = _Tcodes.transactionCode
{
  key Projects.project_uuid                          as ProjectUUID,
      Projects.project_name                          as ProjectName,
      Projects.ecc_tcode                             as EccTcode,
      Projects.s4_tcode                              as S4Tcode,
      Projects.system_source                         as SystemSource,
      Projects.remediated_by                         as RemediatedBy,
      Projects.workstream_lead                       as WorkstreamLead,
      Projects.start_date                            as StartDate,
      Projects.projected_date                        as ProjectedDate,
      Projects.completion_date                       as CompletionDate,

      case when Projects.start_date is null or Projects.start_date is initial
      //           then left( $session.system_date, 4 )
           then '0000'
           else left( Projects.start_date, 4 ) end   as StartYear,

      case when Projects.start_date is null or Projects.start_date is initial
           then 0
           when Projects.projected_date is null or Projects.projected_date is initial
           then 0
           else dats_days_between( Projects.start_date, Projects.projected_date )
            end                                      as ProjectTotalDuration,

      case when Projects.start_date is null or Projects.start_date is initial
           then 0
           when Projects.projected_date is null or Projects.projected_date is initial
           then 0
           when Projects.test_status = '05'
           then dats_days_between( Projects.start_date, Projects.completion_date )
           else dats_days_between( Projects.start_date, $session.system_date )
            end                                      as ProjectDuration,

      case when Projects.start_date is null or Projects.start_date is initial
           then 0
           when dats_days_between( Projects.start_date, Projects.projected_date ) >= dats_days_between( Projects.start_date, $session.system_date )
            and dats_days_between( Projects.start_date, Projects.projected_date ) - dats_days_between( Projects.start_date, $session.system_date ) <= 15
            and Projects.test_status <> '05'
           then 2
           when dats_days_between( Projects.start_date, Projects.projected_date ) >= dats_days_between( Projects.start_date, Projects.completion_date )
            and dats_days_between( Projects.start_date, Projects.projected_date ) - dats_days_between( Projects.start_date, Projects.completion_date ) <= 15
            and Projects.test_status = '05'
           then 3
           when dats_days_between( Projects.start_date, Projects.projected_date ) >= dats_days_between( Projects.start_date, $session.system_date )
            and dats_days_between( Projects.start_date, Projects.projected_date ) - dats_days_between( Projects.start_date, $session.system_date ) > 15
           then 3
           when dats_days_between( Projects.start_date, $session.system_date ) >= dats_days_between( Projects.start_date, Projects.projected_date )
           then 1
           else 0 end                                as ProjectDurationCriticality,

      Projects.developer_assigned                    as DeveloperAssigned,
      Projects.users_assigned                        as UsersAssigned,

      //new Demo to be edited
      Projects.developers_assigned                   as DevelopersAssigned,
      Projects.functionals_assigned                  as FunctionalsAssigned,

      case when Projects.it_group_assigned is initial
           then 'SAP PROGRAM'
           else Projects.it_group_assigned       end as ITGroupAssigned,

      Projects.project_sponsor                       as ProjectSponsor,
      Projects.process_owner                         as ProcessOwner,
      Projects.requestor_company                     as RequestorCompany,
      Projects.requestor_department                  as RequestorDepartment,
      Projects.affected_platforms                    as AffectedPlatforms,
      Projects.charm_number                          as CharmNumber,
      Projects.work_item                             as WorkItem,
      Projects.objective_or_purpose                  as ObjectiveOrPurpose,

      case when Projects.start_date is null or Projects.start_date is initial
           then ''
           when Projects.test_status = '05' and dats_days_between( Projects.start_date, Projects.completion_date ) >= 14
           then 'Project'
           when Projects.test_status = '05' and dats_days_between( Projects.start_date, Projects.completion_date ) < 14
            then 'Maintenance'
           when Projects.test_status <> '05' and dats_days_between( Projects.start_date, Projects.projected_date ) >= 14
           then 'Project'
           when Projects.test_status <> '05' and dats_days_between( Projects.start_date, Projects.projected_date ) < 14
            then 'Maintenance'
           else ''
            end                                      as ProjectType,
      Projects.project_type_description              as ProjectTypeDescription,
      Projects.classification                        as Classification,
      Projects.phase                                 as Phase,
      Projects.effort_saved_or_benefit               as EffortSavedOrBenefit,
      Projects.additional_detail                     as AdditionalDetail,
      Projects.additional_detail_2                   as AdditionalDetail_2,

      case when Projects.start_date is null or Projects.start_date is initial
           then ''
           when Projects.test_status = '05' and dats_days_between( Projects.start_date, Projects.completion_date ) >= 14
            and dats_days_between( Projects.start_date, Projects.completion_date ) >= 90
           then 'High'
           when Projects.test_status = '05' and dats_days_between( Projects.start_date, Projects.completion_date ) >= 14
            and ( dats_days_between( Projects.start_date, Projects.completion_date ) > 30 and dats_days_between( Projects.start_date, Projects.completion_date ) < 90 )
           then 'Medium'
           when Projects.test_status = '05' and dats_days_between( Projects.start_date, Projects.completion_date ) >= 14
            and dats_days_between( Projects.start_date, Projects.completion_date ) <= 30
           then 'Low'
           when Projects.test_status <> '05' and dats_days_between( Projects.start_date, Projects.projected_date ) >= 14
            and dats_days_between( Projects.start_date, Projects.projected_date ) >= 90
           then 'High'
           when Projects.test_status <> '05' and dats_days_between( Projects.start_date, Projects.projected_date ) >= 14
            and ( dats_days_between( Projects.start_date, Projects.projected_date ) > 30 and dats_days_between( Projects.start_date, Projects.projected_date ) < 90 )
           then 'Medium'
           when Projects.test_status <> '05' and dats_days_between( Projects.start_date, Projects.projected_date ) >= 14
            and dats_days_between( Projects.start_date, Projects.projected_date ) <= 30
           then 'Low'

           when Projects.test_status = '05' and dats_days_between( Projects.start_date, Projects.completion_date ) < 14
            and ( dats_days_between( Projects.start_date, Projects.completion_date ) >= 10 and dats_days_between( Projects.start_date, Projects.completion_date ) <= 7 )
           then 'High'
           when Projects.test_status = '05' and dats_days_between( Projects.start_date, Projects.completion_date ) < 14
            and ( dats_days_between( Projects.start_date, Projects.completion_date ) >= 4 and dats_days_between( Projects.start_date, Projects.completion_date ) <= 6 )
           then 'Medium'
           when Projects.test_status = '05' and dats_days_between( Projects.start_date, Projects.completion_date ) < 14
            and ( dats_days_between( Projects.start_date, Projects.completion_date ) >= 1 and dats_days_between( Projects.start_date, Projects.completion_date ) <= 3 )
           then 'Low'
           when Projects.test_status <> '05' and dats_days_between( Projects.start_date, Projects.projected_date ) < 14
            and ( dats_days_between( Projects.start_date, Projects.completion_date ) >= 10 and dats_days_between( Projects.start_date, Projects.projected_date ) <= 7 )
           then 'High'
           when Projects.test_status <> '05' and dats_days_between( Projects.start_date, Projects.projected_date ) < 14
            and ( dats_days_between( Projects.start_date, Projects.projected_date ) >= 4 and dats_days_between( Projects.start_date, Projects.projected_date ) <= 6 )
           then 'Medium'
           when Projects.test_status <> '05' and dats_days_between( Projects.start_date, Projects.projected_date ) < 14
            and ( dats_days_between( Projects.start_date, Projects.projected_date ) >= 1 and dats_days_between( Projects.start_date, Projects.projected_date ) <= 3 )
           then 'Low'

           else ''
            end                                      as Complexity,
      Projects.test_status                           as TestStatus,
      _Status.Description                            as StatusDescription,

      case when Projects.test_status = '00'
           then 5

      /*In Progress*/
           when Projects.test_status = '01'
            and Projects.projected_date < $session.system_date
           then 1 /*Deadline reached*/
           when Projects.test_status = '01'
            and dats_days_between( $session.system_date, Projects.projected_date ) < 15
           then 2 /*Deadline is close approaching*/
           when Projects.test_status = '01'
            and Projects.projected_date > $session.system_date
           then 0

           when Projects.test_status = '02'
           then 2
           when Projects.test_status = '05'
           then 3
           else 5 end                                as StatusCriticality,

      Priority.Value                                 as Priority,
      Priority.Description                           as PriorityDescription,
      Priority.Value                                 as PriorityCriticality,
      Projects.projected_worklog                     as ProjectedWorkHours,
      Projects.actual_worklog                        as TotalWorkHours,
      Projects.actual_worklog                        as WorkLogChartValue,

      case when Projects.projected_worklog = 0
           then 1
           when division( Projects.actual_worklog, Projects.projected_worklog, 2 ) <= 1
           then 3
           when division( Projects.actual_worklog, Projects.projected_worklog, 2 ) > 1
              and division( Projects.actual_worklog, Projects.projected_worklog, 2 ) <= 1.2
           then 2
           else 1
            end                                      as WorkLogCriticality,

      case when Projects.progress_indicator > 100
           then 100
           else Projects.progress_indicator
           end                                       as ProgressIndicator,

      @Semantics.user.createdBy: true
      Projects.created_by                            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      Projects.created_at                            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      Projects.last_changed_by                       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      Projects.last_changed_at                       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Projects.local_last_changed_at                 as LocalLastChangedAt,

      /*Associations*/
      _Objects,
      _Systems,
      _Status,
      _Priority,
      _Users,
      _Tcodes,
      _Worklogs,
      _Charms,
      _Feeds,
      _UserAssigned,
      _Actions
}
