CLASS lhc_objects DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Objects RESULT result.

ENDCLASS.

CLASS lhc_objects IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Objects BY \_Projects
        FIELDS ( TestStatus )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Objects
        ALL FIELDS WITH
        CORRESPONDING #( keys )
      RESULT DATA(objects).

    IF projects IS INITIAL OR objects IS INITIAL.
      RETURN.
    ENDIF.

    DATA(project) = projects[ 1 ].
    result = VALUE #( FOR object IN objects
                      LET is_disable = COND #( WHEN project-TestStatus = zcl_projects_demo_helper=>get_project_status( to_lower( 'COMPLETED' ) )
                                               THEN if_abap_behv=>fc-o-disabled
                                               ELSE if_abap_behv=>fc-o-enabled )
                      IN ( %tky = object-%tky
                           %features-%delete = is_disable ) ).

  ENDMETHOD.

ENDCLASS.
