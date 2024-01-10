CLASS lhc_Charms DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Charms RESULT result.
    METHODS collatecharms FOR DETERMINE ON SAVE
      IMPORTING keys FOR charms~collatecharms.

ENDCLASS.

CLASS lhc_Charms IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD collateCharms.
    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Charms
        FIELDS ( ProjectUUID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY Projects
        EXECUTE recollateCharms
        FROM CORRESPONDING #( projects )
      REPORTED DATA(executed_reported).

    reported = CORRESPONDING #( DEEP executed_reported ).
  ENDMETHOD.

ENDCLASS.
