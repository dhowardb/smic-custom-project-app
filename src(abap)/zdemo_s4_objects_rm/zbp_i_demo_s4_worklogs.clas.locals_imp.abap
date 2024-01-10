CLASS lhc_worklogs DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Worklogs RESULT result.
    METHODS calculatetotalworklogs FOR DETERMINE ON SAVE
      IMPORTING keys FOR worklogs~calculatetotalworklogs.
    METHODS calculatetotalprogress FOR DETERMINE ON SAVE
      IMPORTING keys FOR worklogs~calculatetotalprogress.

ENDCLASS.

CLASS lhc_worklogs IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Worklogs BY \_Projects
        FIELDS ( TestStatus )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Worklogs
        ALL FIELDS WITH
        CORRESPONDING #( keys )
      RESULT DATA(worklogs).

    IF projects IS INITIAL OR worklogs IS INITIAL.
      RETURN.
    ENDIF.

    DATA(project) = projects[ 1 ].
    result = VALUE #( FOR worklog IN worklogs
                      LET is_disable = COND #( WHEN project-TestStatus = zcl_projects_demo_helper=>get_project_status( to_lower( 'COMPLETED' ) )
                                               THEN if_abap_behv=>fc-o-disabled
                                               ELSE if_abap_behv=>fc-o-enabled )
                      IN ( %tky = worklog-%tky
                           %features-%delete = is_disable
                           %features-%update = is_disable
                            ) ).
  ENDMETHOD.

  METHOD calculateTotalWorkLogs.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( ProjectUUID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        EXECUTE recalculateTotalWorkLogs
        FROM CORRESPONDING #( projects )
      REPORTED DATA(executed_reported).

    reported = CORRESPONDING #( DEEP executed_reported ).

  ENDMETHOD.

  METHOD calculateTotalProgress.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( ProjectUUID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        EXECUTE recalculateTotalProgress
        FROM CORRESPONDING #( projects )
      REPORTED DATA(executed_reported).

    reported = CORRESPONDING #( DEEP executed_reported ).
  ENDMETHOD.

ENDCLASS.
