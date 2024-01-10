CLASS ltc_Projects DEFINITION DEFERRED FOR TESTING.
CLASS lhc_Projects DEFINITION INHERITING FROM cl_abap_behavior_handler FRIENDS ltc_projects.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF is_draft_state,
        on  TYPE abp_behv_flag VALUE '01',
        off TYPE abp_behv_flag VALUE '00',
      END OF is_draft_state.

    CONSTANTS:
      BEGIN OF user_roles,
        developer  TYPE string VALUE 'DEVELOPER',
        functional TYPE string  VALUE 'FUNCTIONAL',
      END OF user_roles.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Projects RESULT result.
    METHODS setprojectinitialstatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR projects~setprojectinitialstatus.
    METHODS setprojectinitialpriority FOR DETERMINE ON MODIFY
      IMPORTING keys FOR projects~setprojectinitialpriority.
    METHODS validateprojectnotinitial FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validateprojectnotinitial.
    METHODS validatedates FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validatedates.

    METHODS validatepriority FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validatepriority.

    METHODS validatestatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validatestatus.

    METHODS validatetcodes FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validatetcodes.
    METHODS validatedeveloper FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validatedeveloper.

    METHODS validateremediatedby FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validateremediatedby.

    METHODS validateworkstreamlead FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validateworkstreamlead.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR projects RESULT result.

    METHODS completeproject FOR MODIFY
      IMPORTING keys FOR ACTION projects~completeproject RESULT result.
    METHODS resetproject FOR MODIFY
      IMPORTING keys FOR ACTION projects~resetproject RESULT result.
    METHODS addobjectsviatr FOR MODIFY
      IMPORTING keys FOR ACTION projects~addobjectsviatr RESULT result.
    METHODS recalculatetotalworklogs FOR MODIFY
      IMPORTING keys FOR ACTION projects~recalculatetotalworklogs.
    METHODS recalculatetotalprogress FOR MODIFY
      IMPORTING keys FOR ACTION projects~recalculatetotalprogress.
    METHODS recollateusersassigned FOR MODIFY
      IMPORTING keys FOR ACTION projects~recollateusersassigned.
    METHODS recollatecharms FOR MODIFY
      IMPORTING keys FOR ACTION projects~recollatecharms.
    METHODS validateitgroupnotinitial FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validateitgroupnotinitial.
    METHODS validatestartdatenotinitial FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validatestartdatenotinitial.
    METHODS validatestartdatenotstarted FOR VALIDATE ON SAVE
      IMPORTING keys FOR projects~validatestartdatenotstarted.
    METHODS recollatedevelopersassigned FOR MODIFY
      IMPORTING keys FOR ACTION projects~recollatedevelopersassigned.

    METHODS recollatefunctionalsassigned FOR MODIFY
      IMPORTING keys FOR ACTION projects~recollatefunctionalsassigned.

    "Helper methods
    METHODS get_status_notstarted
      RETURNING VALUE(return) TYPE char02.
ENDCLASS.

CLASS lhc_Projects IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD setProjectInitialStatus.

    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
      FIELDS ( TestStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    "Remove instance with status not initial
    DELETE projects WHERE TestStatus IS NOT INITIAL.
    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
      UPDATE
        FIELDS ( TestStatus )
        WITH VALUE #( FOR project IN projects ( %tky = project-%tky
                                                TestStatus = zcl_projects_demo_helper=>get_initial_demo_status( ) ) )
        REPORTED DATA(updated_reported).

    reported = CORRESPONDING #( DEEP updated_reported ).
  ENDMETHOD.

  METHOD setProjectInitialPriority.

    "Read relevant instances
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( Priority )
        WITH CORRESPONDING #( keys )
        RESULT DATA(Projects).

    "Delete instance with priority already set
    DELETE projects WHERE Priority IS NOT INITIAL.
    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    "Set initial status as Low
    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        UPDATE
          FIELDS ( Priority )
          WITH VALUE #( FOR <project> IN projects
                      ( %tky = <project>-%tky
                        Priority = NEW zcl_projects_demo_helper( )->get_initial_demo_priority( ) ) )

          REPORTED DATA(updated_reported).

    reported = CORRESPONDING #( DEEP updated_reported ).
  ENDMETHOD.

  METHOD validateProjectNotInitial.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( ProjectName )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DATA(project_instance) = VALUE #( projects[ 1 ] OPTIONAL ).
    "Clear state messages
    APPEND VALUE #( %tky = project_instance-%tky
                    %state_area = 'VALIDATE_PROJECTNAME'
                    ) TO reported-projects.

    IF project_instance-ProjectName IS INITIAL.
      APPEND VALUE #( %tky = project_instance-%tky ) TO failed-projects.
      APPEND VALUE #( %tky = project_instance-%tky
                      %state_area = 'VALIDATE_PROJECTNAME'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>initial_project_name
                                                  severity = if_abap_behv_message=>severity-error )
                      %element-ProjectName = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.

  ENDMETHOD.

  METHOD validateITGroupNotInitial.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( ITGroupAssigned )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DATA(project_instance) = VALUE #( projects[ 1 ] OPTIONAL ).
    "Clear state messages
    APPEND VALUE #( %tky = project_instance-%tky
                    %state_area = 'VALIDATE_ITGROUPASSIGNED'
                    ) TO reported-projects.

    IF project_instance-ITGroupAssigned IS INITIAL.
      APPEND VALUE #( %tky = project_instance-%tky ) TO failed-projects.
      APPEND VALUE #( %tky = project_instance-%tky
                      %state_area = 'VALIDATE_ITGROUPASSIGNED'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>initial_it_group
                                                  severity = if_abap_behv_message=>severity-error )
                      %element-ITGroupAssigned = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.
  ENDMETHOD.

  METHOD validateDates.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( ProjectedDate StartDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DELETE projects WHERE ProjectedDate IS INITIAL.
    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    DATA(project) = projects[ 1 ].
    APPEND VALUE #( %tky = project-%tky
                    %state_area = 'VALIDATE_PROJECTED_DATE' ) TO reported-projects.

    APPEND VALUE #( %tky = project-%tky
                    %state_area = 'VALIDATE_START_DATE' ) TO reported-projects.

    IF project-ProjectedDate < project-StartDate.
      APPEND VALUE #( %tky = project-%tky ) TO failed-projects.

      APPEND VALUE #( %tky = project-%tky
                      %state_area = 'VALIDATE_PROJECTED_DATE'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>projected_date_invalid
                                                  severity = if_abap_behv_message=>severity-error
                                                  projected_date = project-ProjectedDate )
                      %element-ProjectedDate = if_abap_behv=>mk-on ) TO reported-projects.

      APPEND VALUE #( %tky = project-%tky
                      %state_area = 'VALIDATE_START_DATE'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>start_date_invalid
                                                  severity = if_abap_behv_message=>severity-error
                                                  start_date = project-StartDate )
                      %element-StartDate = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.

  ENDMETHOD.

  METHOD validatePriority.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( Priority )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    "No need to validate initial due to method setinitial
    DELETE projects WHERE Priority IS INITIAL.
    IF projects IS INITIAL.
      RETURN.
    ENDIF.
    DATA(project_instance) = projects[ 1 ].

    SELECT FROM zi_demo_priority
      FIELDS
        Value,
        Description
      WHERE value IS NOT NULL
      ORDER BY value
      INTO TABLE @DATA(priorities).

    "Check if loop is needed
*    DATA valid_projects TYPE TABLE FOR READ RESULT zi_demo_s4_project_interface\\projects.
*    valid_projects = VALUE #( FOR <project> IN projects LET project_priority = <project>-Priority IN
*                              FOR <priority> IN priorities WHERE ( value = project_priority ) ( <project> ) ).

    "Clear state messages
    APPEND VALUE #( %tky = project_instance-%tky
                    %state_area = 'VALIDATE_PRIORITY' ) TO reported-projects.

    IF priorities IS INITIAL OR NOT line_exists( priorities[ value = project_instance-Priority ] ).
      APPEND VALUE #( %tky = project_instance-%tky ) TO failed-projects.
      APPEND VALUE #( %tky = project_instance-%tky
                      %state_area = 'VALIDATE_PRIORITY'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>priority_invalid
                                                  severity = if_abap_behv_message=>severity-error
                                                  priority = project_instance-Priority )
                      %element-Priority = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.

  ENDMETHOD.

  METHOD validateStatus.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( TestStatus )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    "No need to validate initial due to method setinitial
    DELETE projects WHERE TestStatus IS INITIAL.
    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    DATA(project) = projects[ 1 ].

    SELECT FROM zi_demo_status
      FIELDS
        Status,
        Description
      WHERE Status IS NOT NULL
      ORDER BY Status
      INTO TABLE @DATA(Statuses).

    APPEND VALUE #( %tky = project-%tky
                    %state_area = 'VALIDATE_STATUS' ) TO reported-projects.

    IF statuses IS INITIAL OR NOT line_exists( statuses[ Status = project-TestStatus ] ).
      APPEND VALUE #( %tky = project-%tky ) TO failed-projects.

      APPEND VALUE #( %tky = project-%tky
                      %state_area = 'VALIDATE_STATUS'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>status_invalid
                                                  severity = if_abap_behv_message=>severity-error
                                                  status = project-TestStatus )
                      %element-TestStatus = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.

  ENDMETHOD.

  METHOD validateTCodes.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( S4Tcode
                 EccTcode )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DELETE projects WHERE S4Tcode IS INITIAL.
    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    DATA(project) = projects[ 1 ].

    SELECT FROM zi_demo_tcodes
      FIELDS
        transactionCode,
        programName
      WHERE transactionCode IS NOT NULL
      ORDER BY transactionCode
      INTO TABLE @DATA(transactions).

    APPEND VALUE #( %tky = project-%tky
                    %state_area = 'VALIDATE_TRANSACTION_CODE' ) TO reported-projects.

    IF transactions IS INITIAL OR NOT line_exists( transactions[ transactionCode = project-S4Tcode ] ).
      APPEND VALUE #( %tky = project-%tky ) TO failed-projects.

      APPEND VALUE #( %tky = project-%tky
                      %state_area = 'VALIDATE_TRANSACTION_CODE'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>transaction_code_invalid
                                                  severity = if_abap_behv_message=>severity-error
                                                  transaction_code = project-S4Tcode )
                      %element-S4Tcode = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.
  ENDMETHOD.



  METHOD validateDeveloper.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( DeveloperAssigned )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DELETE projects WHERE DeveloperAssigned IS INITIAL.
    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    DATA(project) = projects[ 1 ].

    SELECT FROM zi_demo_users
      FIELDS
        UserName
      WHERE UserName IS NOT NULL
      ORDER BY UserName
      INTO TABLE @DATA(Users).

    APPEND VALUE #( %tky = project-%tky
                    %state_area = 'VALIDATE_DEVELOPER' ) TO reported-projects.

    IF users IS INITIAL OR NOT line_exists( users[ UserName = project-DeveloperAssigned ] ).
      APPEND VALUE #( %tky = project-%tky ) TO failed-projects.

      APPEND VALUE #( %tky = project-%tky
                      %state_area = 'VALIDATE_DEVELOPER'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>user_not_found
                                                  severity = if_abap_behv_message=>severity-error
                                                  username = CONV syuname( project-DeveloperAssigned ) )
                      %element-DeveloperAssigned = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.
  ENDMETHOD.

  METHOD validateRemediatedBy.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( RemediatedBy )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DELETE projects WHERE RemediatedBy IS INITIAL.
    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    DATA(project) = projects[ 1 ].

    SELECT FROM zi_demo_users
      FIELDS
        UserName
      WHERE UserName IS NOT NULL
      ORDER BY UserName
      INTO TABLE @DATA(Users).

    APPEND VALUE #( %tky = project-%tky
                    %state_area = 'VALIDATE_REMEDIATED_BY' ) TO reported-projects.

    IF users IS INITIAL OR NOT line_exists( users[ UserName = project-RemediatedBy ] ).
      APPEND VALUE #( %tky = project-%tky ) TO failed-projects.

      APPEND VALUE #( %tky = project-%tky
                      %state_area = 'VALIDATE_REMEDIATED_BY'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>user_not_found
                                                  severity = if_abap_behv_message=>severity-error
                                                  username = CONV syuname( project-RemediatedBy ) )
                      %element-RemediatedBy = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.
  ENDMETHOD.

  METHOD validateWorkStreamLead.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( WorkstreamLead )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DELETE projects WHERE WorkstreamLead IS INITIAL.
    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    DATA(project) = projects[ 1 ].

    SELECT FROM zi_demo_users
      FIELDS
        UserName
      WHERE UserName IS NOT NULL
      ORDER BY UserName
      INTO TABLE @DATA(Users).

    APPEND VALUE #( %tky = project-%tky
                    %state_area = 'VALIDATE_WORKSTREAM_LEAD' ) TO reported-projects.

    IF users IS INITIAL OR NOT line_exists( users[ UserName = project-WorkstreamLead ] ).
      APPEND VALUE #( %tky = project-%tky ) TO failed-projects.

      APPEND VALUE #( %tky = project-%tky
                      %state_area = 'VALIDATE_WORKSTREAM_LEAD'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>user_not_found
                                                  severity = if_abap_behv_message=>severity-error
                                                  username = CONV syuname( project-WorkstreamLead ) )
                      %element-WorkstreamLead = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( TestStatus )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    "With draft
    DATA(draft_result) = result.
    DATA(non_draft_result) = result.
    draft_result = VALUE #( FOR project IN projects WHERE ( %is_draft = is_draft_state-on )
                            LET is_disable = if_abap_behv=>fc-o-disabled
                                is_editable = COND #( WHEN project-TestStatus = zcl_projects_demo_helper=>get_project_status( to_lower( 'COMPLETED' ) ) "O5
                                                      THEN if_abap_behv=>fc-o-disabled
                                                      ELSE if_abap_behv=>fc-o-enabled )
                            IN
                              ( %tky = project-%tky
                                %action-completeProject = is_disable
                                %action-resetProject = is_disable
*                                %action-addObjectsViaTR = is_editable
                                %action-addObjectsViaTR = is_disable
                                %update = is_editable
                                %assoc-_Worklogs = is_editable ) ).

    "Non Draft
    non_draft_result = VALUE #( FOR project IN projects WHERE ( %is_draft = is_draft_state-off )
                                LET is_editable = COND #( WHEN project-TestStatus = zcl_projects_demo_helper=>get_project_status( to_lower( 'COMPLETED' ) ) "O5
                                                          THEN if_abap_behv=>fc-o-disabled
                                                          ELSE if_abap_behv=>fc-o-enabled )
                                IN
                                  ( %tky = project-%tky
                                    %action-completeProject = is_editable
                                    %action-resetProject = COND #( WHEN is_editable = if_abap_behv=>fc-o-disabled THEN if_abap_behv=>fc-o-enabled
                                                                   ELSE if_abap_behv=>fc-o-disabled )
                                    %update = is_editable
*                                    %action-addObjectsViaTR = if_abap_behv=>fc-o-disabled
*                                    %action-addObjectsViaTR = if_abap_behv=>fc-o-enabled
                                    %action-addObjectsViaTR = is_editable
                                    %assoc-_Worklogs = is_editable ) ).

    APPEND LINES OF draft_result[] TO result[].
    APPEND LINES OF non_draft_result[] TO result[].
  ENDMETHOD.

  METHOD completeProject.
    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        UPDATE
          FIELDS ( TestStatus CompletionDate )
          WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                          TestStatus = zcl_projects_demo_helper=>get_project_status( to_lower( 'COMPLETED' ) )
                                          CompletionDate = sy-datum ) )
        FAILED failed
        REPORTED reported.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DELETE projects WHERE TestStatus <> zcl_projects_demo_helper=>get_project_status( to_lower( 'COMPLETED' ) ).

    "Limitations due to having no side effects in S4 Hana 2021
    IF projects IS INITIAL. "add error message that action is not allowed
      RETURN.
    ENDIF.

    result = VALUE #( FOR project IN projects ( %tky = project-%tky
                                                %param = project ) ).
  ENDMETHOD.

  METHOD resetProject.
    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        UPDATE
          FIELDS ( TestStatus CompletionDate StartDate )
          WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                          TestStatus = zcl_projects_demo_helper=>get_project_status( to_lower( 'Not yet assigned' ) )
                                          CompletionDate = '00000000'
                                          StartDate = '00000000' ) )
        FAILED failed
        REPORTED reported.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DELETE projects WHERE TestStatus <> zcl_projects_demo_helper=>get_project_status( to_lower( 'Not yet assigned' ) ).
    IF projects IS INITIAL. "add error message that action is not allowed
      RETURN.
    ENDIF.

    result = VALUE #( FOR project IN projects ( %tky = project-%tky
                                                %param = project ) ).
  ENDMETHOD.

  METHOD addObjectsViaTR.
    DATA(key) = keys[ 1 ].

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    SELECT FROM zi_demo_tr_with_objects
      FIELDS
        TransportRequest,
        ParentTransportRequest,
        ObjectName,
        ObjectType,
        ObjectFunction,
        TransportStatus,
        ObjectCreatedBy,
        ObjectPackage,
        ObjectCreatedAt
      WHERE TransportRequest = @key-%param-addObjectsPerTR
      ORDER BY ParentTransportRequest
      INTO TABLE @DATA(objects_per_tr).

    DATA(project) = projects[ 1 ].

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects BY \_Objects
      FIELDS ( TransportRequest
               ObjectName
               ObjectType
               ObjectPackage
               ObjectOwner )
      WITH CORRESPONDING #( keys )
      RESULT DATA(proj_objects).

    LOOP AT objects_per_tr REFERENCE INTO DATA(object_per_tr).

      IF line_exists( proj_objects[ TransportRequest = object_per_tr->TransportRequest
                                    ObjectName = object_per_tr->ObjectName
                                    ObjectType = object_per_tr->ObjectType
                                    ObjectPackage = object_per_tr->ObjectPackage
                                    ObjectOwner = object_per_tr->ObjectCreatedBy ] ).
*        APPEND VALUE #( %tky = project-%tky ) TO failed-projects.
*
*        APPEND VALUE #( %tky = project-%tky
*                        %state_area = 'DUPLICATE_OBJECTS' ) TO reported-projects.
*
*        APPEND VALUE #( %tky = project-%tky
*                        %state_area = 'DUPLICATE_OBJECTS'
*                        %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>duplicate_objects_added
*                                                    severity = if_abap_behv_message=>severity-error
*                                                    transport_request = key-%param-addObjectsPerTR ) ) TO reported-projects.
*        RETURN.
        CONTINUE.
      ENDIF.

      MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
       ENTITY Projects
         CREATE BY \_Objects
         FIELDS ( ObjectName ObjectType ObjectOwner ObjectOwnerLastChangedAt TransportRequest ObjectPackage ProjectName
                  CreatedBy CreatedAt )
         AUTO FILL CID WITH VALUE #( FOR <key> IN keys
                                       ( %key = project-%key
                                         %target = VALUE #( ( ObjectName = object_per_tr->ObjectName
                                                              ObjectType = object_per_tr->ObjectType
                                                              ObjectOwner = object_per_tr->ObjectCreatedBy
                                                              TransportRequest = object_per_tr->TransportRequest
                                                              ObjectPackage = object_per_tr->ObjectPackage
                                                              ObjectOwnerLastChangedAt = object_per_tr->ObjectCreatedAt
                                                              ProjectName = project-ProjectName ) ) ) )
        MAPPED DATA(mapped_data)
        FAILED DATA(failed_data)
        REPORTED DATA(reported_data).

      IF reported_data IS NOT INITIAL.
        reported = CORRESPONDING #( DEEP reported_data ).
        EXIT.
      ENDIF.

    ENDLOOP.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects BY \_Objects
      ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(projects_with_objects).

    result = VALUE #( FOR project_obj IN projects_with_objects ( %tky = project-%tky
                                                                 %param = project ) ).

*    IF reported IS NOT INITIAL OR result IS INITIAL.
*      APPEND VALUE #( %tky = project-%tky ) TO failed-projects.
*
*      APPEND VALUE #( %tky = project-%tky
*                      %state_area = 'OBJECTS_NOT_CREATED' ) TO reported-projects.
*
*      APPEND VALUE #( %tky = project-%tky
*                      %state_area = 'OBJECTS_NOT_CREATED'
*                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>objects_with_tr_not_found
*                                                  severity = if_abap_behv_message=>severity-error
*                                                  transport_request = key-%param-addObjectsPerTR ) ) TO reported-projects.
*      RETURN.
*    ENDIF.

    IF reported IS INITIAL AND mapped IS NOT INITIAL.
      APPEND VALUE #( %tky = project-%tky
                      %state_area = 'OBJECTS_CREATED' ) TO reported-projects.

      APPEND VALUE #( %tky = project-%tky
                      %state_area = 'OBJECTS_CREATED'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>objects_created_success
                                                  severity = if_abap_behv_message=>severity-success ) ) TO reported-projects.
    ENDIF.
  ENDMETHOD.

  METHOD recalculateTotalWorkLogs.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( TotalWorkHours )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects)
      REPORTED reported.

    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects BY \_Worklogs
        FIELDS ( LogHours )
        WITH CORRESPONDING #( keys )
      RESULT DATA(worklogs).

    DATA(total_worklog) = REDUCE i( INIT log_hour = 0
                                    FOR worklog IN worklogs
                                    NEXT log_hour += worklog-LogHours ).

    LOOP AT projects REFERENCE INTO DATA(project).
      CLEAR project->TotalWorkHours.
      project->TotalWorkHours = total_worklog.
    ENDLOOP.

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        UPDATE FIELDS ( TotalWorkHours )
          WITH CORRESPONDING #( projects )
        MAPPED mapped
        REPORTED reported
        FAILED failed.

  ENDMETHOD.

  METHOD recalculatetotalprogress.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( TotalWorkHours )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects)
      REPORTED reported.

    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects BY \_Worklogs
        FIELDS ( ProgressValue )
        WITH CORRESPONDING #( keys )
      RESULT DATA(worklogs).

    DATA(total_progress) = REDUCE i( INIT progress = 0
                                     FOR worklog IN worklogs
                                     NEXT progress += worklog-ProgressValue ).

    IF total_progress > 100.
      DATA(temp_project) = projects[ 1 ].
      APPEND VALUE #( %tky = temp_project-%tky ) TO failed-projects.

      APPEND VALUE #( %tky = temp_project-%tky
                      %state_area = 'PROGRESS_GT_100' ) TO reported-projects.

      APPEND VALUE #( %tky = temp_project-%tky
                      %state_area = 'PROGRESS_GT_100'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>progress_value_more_than_100
                                                  severity = if_abap_behv_message=>severity-error
                                                  progress_value = CONV #( total_progress ) ) ) TO reported-projects.
      RETURN.
    ENDIF.

*    DATA temp_projects LIKE projects.
*    temp_projects = VALUE #( FOR temp_project IN projects ( VALUE #( BASE temp_project ProgressIndicator = total_progress ) ) ).
    LOOP AT projects REFERENCE INTO DATA(project).
      CLEAR project->ProgressIndicator.
      project->ProgressIndicator = total_progress.
    ENDLOOP.

*    projects = temp_projects.

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        UPDATE FIELDS ( ProgressIndicator )
          WITH CORRESPONDING #( projects )
        MAPPED mapped
        REPORTED reported
        FAILED failed.
  ENDMETHOD.

  METHOD recollateUsersAssigned.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
      FIELDS ( UsersAssigned )
      WITH CORRESPONDING #( keys )
    RESULT DATA(projects)
    REPORTED reported.

    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects BY \_UserAssigned
      FIELDS ( UsersAssigned )
      WITH CORRESPONDING #( keys )
    RESULT DATA(UsersAssigned).

    SELECT FROM zi_demo_users
      FIELDS
        UserName,
        FullName,
        UserRole
      ORDER BY UserName
      INTO TABLE @DATA(Users_available).

    IF users_available IS INITIAL.
      RETURN.
    ENDIF.

    LOOP AT projects REFERENCE INTO DATA(project).
      CLEAR project->UsersAssigned.
      CLEAR: project->FunctionalsAssigned,
             project->DevelopersAssigned.

      project->UsersAssigned = COND string( WHEN lines( usersassigned ) = 1
                                            THEN VALUE #( users_available[ UserName = usersassigned[ 1 ]-UsersAssigned ]-FullName OPTIONAL )
                                            ELSE REDUCE string( INIT users TYPE string
                                                                     separator = ''
                                                                FOR user IN usersassigned
                                                                NEXT users = |{ users }{ separator } { VALUE #( users_available[ UserName = user-UsersAssigned ]-FullName OPTIONAL ) }|
                                                                separator = ',' ) ).
    ENDLOOP.

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        UPDATE FIELDS ( UsersAssigned )
          WITH CORRESPONDING #( projects )
      MAPPED mapped
      REPORTED reported
      FAILED failed.

  ENDMETHOD.

  METHOD recollateDevelopersAssigned.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
      FIELDS ( DevelopersAssigned )
      WITH CORRESPONDING #( keys )
    RESULT DATA(projects)
    REPORTED reported.

    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects BY \_UserAssigned
      FIELDS ( UsersAssigned )
      WITH CORRESPONDING #( keys )
    RESULT DATA(UsersAssigned).

    SELECT FROM zi_demo_users
      FIELDS
        UserName,
        FullName,
        UserRole
      WHERE UserRole = @user_roles-developer
      ORDER BY UserName
      INTO TABLE @DATA(Users_available).

    IF users_available IS INITIAL.
      RETURN.
    ENDIF.

    "Clear previous data
    LOOP AT projects REFERENCE INTO DATA(project_remove_devs).
      CLEAR project_remove_devs->DevelopersAssigned.
    ENDLOOP.

    LOOP AT usersassigned REFERENCE INTO DATA(userassigned).

      IF NOT line_exists( Users_available[ UserName = userassigned->UsersAssigned ] ).
        CONTINUE.
      ENDIF.

      LOOP AT projects REFERENCE INTO DATA(project).
        project->DevelopersAssigned = COND #( WHEN project->DevelopersAssigned IS INITIAL
                                              THEN | { VALUE #( users_available[ UserName = userassigned->UsersAssigned ]-FullName OPTIONAL ) } |
                                              ELSE | { project->DevelopersAssigned }, { VALUE #( users_available[ UserName = userassigned->UsersAssigned ]-FullName OPTIONAL ) } | ).
*        project->DevelopersAssigned = | { project->DevelopersAssigned }, { userassigned->UsersAssigned } |.
*        project->DevelopersAssigned = COND string( WHEN lines( usersassigned ) = 1
*                                                   THEN VALUE #( users_available[ UserName = usersassigned[ 1 ]-UsersAssigned ]-FullName OPTIONAL )
*                                                   ELSE REDUCE string( INIT users TYPE string
*                                                                            separator = ''
*                                                                       FOR user IN usersassigned
*                                                                       NEXT users = |{ users }{ separator } { VALUE #( users_available[ UserName = userassigned->UsersAssigned
*                                                                                                                                        UserRole = 'Developer' ]-FullName OPTIONAL ) }|
*                                                                            separator = ',' ) ).
      ENDLOOP.

    ENDLOOP.

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        UPDATE FIELDS ( DevelopersAssigned )
          WITH CORRESPONDING #( projects )
      MAPPED mapped
      REPORTED reported
      FAILED failed.
  ENDMETHOD.

  METHOD recollateFunctionalsAssigned.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
      FIELDS ( FunctionalsAssigned )
      WITH CORRESPONDING #( keys )
    RESULT DATA(projects)
    REPORTED reported.

    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects BY \_UserAssigned
      FIELDS ( UsersAssigned )
      WITH CORRESPONDING #( keys )
    RESULT DATA(UsersAssigned).

    SELECT FROM zi_demo_users
      FIELDS
        UserName,
        FullName,
        UserRole
      WHERE UserRole = @user_roles-functional
      ORDER BY UserName
      INTO TABLE @DATA(Users_available).

    IF users_available IS INITIAL.
      RETURN.
    ENDIF.

    "Clear previous data
    LOOP AT projects REFERENCE INTO DATA(project_remove_functionals).
      CLEAR project_remove_functionals->FunctionalsAssigned.
    ENDLOOP.

    LOOP AT usersassigned REFERENCE INTO DATA(userassigned).

      IF NOT line_exists( Users_available[ UserName = userassigned->UsersAssigned ] ).
        CONTINUE.
      ENDIF.

      LOOP AT projects REFERENCE INTO DATA(project).
        project->FunctionalsAssigned = COND #( WHEN project->FunctionalsAssigned IS INITIAL
                                              THEN | { VALUE #( users_available[ UserName = userassigned->UsersAssigned ]-FullName OPTIONAL ) } |
                                              ELSE | { project->FunctionalsAssigned }, { VALUE #( users_available[ UserName = userassigned->UsersAssigned ]-FullName OPTIONAL ) } | ).
*        project->DevelopersAssigned = | { project->DevelopersAssigned }, { userassigned->UsersAssigned } |.
*        project->DevelopersAssigned = COND string( WHEN lines( usersassigned ) = 1
*                                                   THEN VALUE #( users_available[ UserName = usersassigned[ 1 ]-UsersAssigned ]-FullName OPTIONAL )
*                                                   ELSE REDUCE string( INIT users TYPE string
*                                                                            separator = ''
*                                                                       FOR user IN usersassigned
*                                                                       NEXT users = |{ users }{ separator } { VALUE #( users_available[ UserName = userassigned->UsersAssigned
*                                                                                                                                        UserRole = 'Developer' ]-FullName OPTIONAL ) }|
*                                                                            separator = ',' ) ).
      ENDLOOP.

    ENDLOOP.

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        UPDATE FIELDS ( FunctionalsAssigned )
          WITH CORRESPONDING #( projects )
      MAPPED mapped
      REPORTED reported
      FAILED failed.
  ENDMETHOD.

  METHOD recollateCharms.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
      FIELDS ( CharmNumber )
      WITH CORRESPONDING #( keys )
    RESULT DATA(projects)
    REPORTED reported.

    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects BY \_Charms
      FIELDS ( CharmNumber )
      WITH CORRESPONDING #( keys )
    RESULT DATA(CharmsAssigned).

    LOOP AT projects REFERENCE INTO DATA(project).
      CLEAR project->CharmNumber.
      project->CharmNumber = COND string( WHEN lines( charmsassigned ) = 1
                                          THEN VALUE #( charmsassigned[ 1 ]-CharmNumber OPTIONAL )
                                          ELSE REDUCE string( INIT charms TYPE string
                                                                   separator = ''
                                                                FOR charm IN charmsassigned
                                                                NEXT charms = |{ charms }{ separator } { charm-CharmNumber }|
                                                                separator = ',' ) ).
    ENDLOOP.

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        UPDATE FIELDS ( CharmNumber )
          WITH CORRESPONDING #( projects )
      MAPPED mapped
      REPORTED reported
      FAILED failed.
  ENDMETHOD.

  METHOD get_status_notstarted.
    SELECT FROM zi_demo_status
      FIELDS Status
      WHERE Description = 'Not yet Started'
      INTO @return
      UP TO 1 ROWS.
    ENDSELECT.
  ENDMETHOD.

  METHOD validateStartDateNotInitial.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( StartDate TestStatus )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DATA(project_instance) = VALUE #( projects[ 1 ] OPTIONAL ).
    "Clear state messages
    APPEND VALUE #( %tky = project_instance-%tky
                    %state_area = 'VALIDATE_STARTDATE'
                    ) TO reported-projects.

    IF project_instance-StartDate IS INITIAL AND project_instance-TestStatus = '01'.
      APPEND VALUE #( %tky = project_instance-%tky ) TO failed-projects.
      APPEND VALUE #( %tky = project_instance-%tky
                      %state_area = 'VALIDATE_STARTDATE'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>initial_project_start_date
                                                  severity = if_abap_behv_message=>severity-error )
                      %element-StartDate = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.
  ENDMETHOD.

  METHOD validateStartDateNotStarted.
    "Read instance
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( StartDate TestStatus )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    DATA(project_instance) = VALUE #( projects[ 1 ] OPTIONAL ).
    "Clear state messages
    APPEND VALUE #( %tky = project_instance-%tky
                    %state_area = 'VALIDATE_STARTDATE_NOT_STARTED'
                    ) TO reported-projects.

    IF project_instance-StartDate IS NOT INITIAL AND project_instance-TestStatus = '00'.
      APPEND VALUE #( %tky = project_instance-%tky ) TO failed-projects.
      APPEND VALUE #( %tky = project_instance-%tky
                      %state_area = 'VALIDATE_STARTDATE_NOT_STARTED'
                      %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>not_started_initial_start_date
                                                  severity = if_abap_behv_message=>severity-error )
                      %element-StartDate = if_abap_behv=>mk-on ) TO reported-projects.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
