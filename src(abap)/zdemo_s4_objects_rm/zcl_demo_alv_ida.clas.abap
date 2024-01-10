CLASS zcl_demo_alv_ida DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zif_demo_alv_ida.

    CLASS-DATA
      mo_instance TYPE REF TO zcl_demo_alv_ida.

    DATA
      mo_alv_ida TYPE REF TO if_salv_gui_table_ida.

    METHODS:
      constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_demo_alv_ida IMPLEMENTATION.

  METHOD constructor.

  ENDMETHOD.

  METHOD zif_demo_alv_ida~display.

  ENDMETHOD.

ENDCLASS.
