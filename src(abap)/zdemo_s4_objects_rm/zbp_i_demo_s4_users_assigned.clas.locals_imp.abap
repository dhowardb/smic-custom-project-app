CLASS lhc_UsersAssigned DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR UsersAssigned RESULT result.
    METHODS validateuserisduplicate FOR VALIDATE ON SAVE
      IMPORTING keys FOR usersassigned~validateuserisduplicate.
    METHODS collateusersassigned FOR DETERMINE ON SAVE
      IMPORTING keys FOR usersassigned~collateusersassigned.
    METHODS collatedevelopersassigned FOR DETERMINE ON SAVE
      IMPORTING keys FOR usersassigned~collatedevelopersassigned.

    METHODS collatefunctionalsassigned FOR DETERMINE ON SAVE
      IMPORTING keys FOR usersassigned~collatefunctionalsassigned.

ENDCLASS.

CLASS lhc_UsersAssigned IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD validateUserIsDuplicate.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( UsersAssigned )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    IF projects IS INITIAL.
      RETURN.
    ENDIF.

    DATA(project) = projects[ 1 ].

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY UsersAssigned
        FIELDS ( UsersAssigned )
        WITH CORRESPONDING #( keys )
      RESULT DATA(users_assigned).

    IF users_assigned IS INITIAL.
      RETURN.
    ENDIF.

    DATA(user_assigned) = users_assigned[ 1 ].

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects BY \_UserAssigned
        FIELDS ( UsersAssigned )
          WITH CORRESPONDING #( keys )
        RESULT DATA(users_assigned_by_projects).

    IF users_assigned_by_projects IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY UsersAssigned BY \_Projects
        FIELDS ( UsersAssigned )
          WITH CORRESPONDING #( keys )
        LINK DATA(users_projects_links).

    IF users_projects_links IS INITIAL.
      RETURN.
    ENDIF.

    APPEND VALUE #( %tky = user_assigned-%tky
                    %state_area = 'VALIDATE_USER_ALREADY_ASSIGNED'
                    ) TO reported-usersassigned.

    LOOP AT users_assigned_by_projects REFERENCE INTO DATA(user_assigned_by_project) GROUP BY ( ProjectUuid = user_assigned_by_project->ProjectUuid
                                                                                                UsersAssigned = user_assigned_by_project->UsersAssigned
                                                                                                size = GROUP SIZE )
    ASCENDING REFERENCE INTO DATA(group_user_assigned).

      IF group_user_assigned->size > 1.
        APPEND VALUE #( %tky = user_assigned-%tky ) TO failed-usersassigned.
        APPEND VALUE #( %tky = user_assigned-%tky
                        %state_area = 'VALIDATE_USER_ALREADY_ASSIGNED'
                        %path = VALUE #( projects-%tky = users_projects_links[ source-%tky = user_assigned-%tky ]-target-%tky )
                        %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>user_already_assigned
                                                    severity = if_abap_behv_message=>severity-error
                                                    username = group_user_assigned->usersassigned )
                        %element-UsersAssigned = if_abap_behv=>mk-on ) TO reported-usersassigned.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD collateUsersAssigned.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( ProjectUUID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        EXECUTE recollateUsersAssigned
        FROM CORRESPONDING #( projects )
      REPORTED DATA(executed_reported).

    reported = CORRESPONDING #( DEEP executed_reported ).
  ENDMETHOD.

  METHOD collateDevelopersAssigned.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( ProjectUUID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        EXECUTE recollateDevelopersAssigned
        FROM CORRESPONDING #( projects )
      REPORTED DATA(executed_reported).

    reported = CORRESPONDING #( DEEP executed_reported ).
  ENDMETHOD.

  METHOD collateFunctionalsAssigned.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        FIELDS ( ProjectUUID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        EXECUTE recollateFunctionalsAssigned
        FROM CORRESPONDING #( projects )
      REPORTED DATA(executed_reported).

    reported = CORRESPONDING #( DEEP executed_reported ).
  ENDMETHOD.

ENDCLASS.
