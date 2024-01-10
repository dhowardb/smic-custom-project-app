CLASS lhc_TransportRequests DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR TransportRequests RESULT result.
    METHODS validatetransportisnotinitial FOR VALIDATE ON SAVE
      IMPORTING keys FOR transportrequests~validatetransportisnotinitial.
    METHODS validatetransportrequest FOR VALIDATE ON SAVE
      IMPORTING keys FOR transportrequests~validatetransportrequest.
    METHODS setTransportRequestDescription FOR DETERMINE ON MODIFY
      IMPORTING keys FOR transportrequests~settransportrequestdescription.

ENDCLASS.

CLASS lhc_TransportRequests IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD validateTransportIsNotInitial.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY TransportRequests BY \_Projects
      FIELDS ( ProjectName )
      WITH CORRESPONDING #( keys )
    LINK DATA(trs_projects_link).

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY TransportRequests BY \_Charms
      FIELDS ( CharmNumber )
      WITH CORRESPONDING #( keys )
    LINK DATA(trs_charms_link).

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY TransportRequests
        FIELDS ( TransportRequest )
        WITH CORRESPONDING #( keys )
      RESULT DATA(transport_requests)
      REPORTED DATA(reported_result).

    DELETE transport_requests WHERE TransportRequest IS NOT INITIAL.

    LOOP AT transport_requests REFERENCE INTO DATA(transport_request).

      APPEND VALUE #( %tky = transport_request->%tky
                      %state_area = 'VALIDATE_TRANSPORT_IS_NOT_INITIAL'
                    ) TO reported-transportrequests.

      APPEND VALUE #( ) TO failed-transportrequests.

      APPEND VALUE #( %tky = transport_request->%tky
                        %state_area = 'VALIDATE_TRANSPORT_IS_NOT_INITIAL'
                        %path = VALUE #( projects-%tky = trs_projects_link[ source-%tky = transport_request->%tky ]-target-%tky
                                         charms-%tky = trs_charms_link[ source-%tky = transport_request->%tky ]-target-%tky )
                        %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>transport_request_not_initial
                                                    severity = if_abap_behv_message=>severity-error )
                        %element-transportrequest = if_abap_behv=>mk-on ) TO reported-transportrequests.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateTransportRequest.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY TransportRequests BY \_Projects
      FIELDS ( ProjectName )
      WITH CORRESPONDING #( keys )
      LINK DATA(trs_projects_link).

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY TransportRequests BY \_Charms
      FIELDS ( CharmNumber )
      WITH CORRESPONDING #( keys )
      LINK DATA(trs_charms_link).

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY TransportRequests
      FIELDS ( TransportRequest )
      WITH CORRESPONDING #( keys )
      RESULT DATA(transport_requests).

    LOOP AT transport_requests REFERENCE INTO DATA(transport_request).

      SELECT FROM zi_demo_tr_with_objects
        FIELDS
          TransportRequest
        WHERE TransportRequest = @transport_request->TransportRequest
        ORDER BY TransportRequest
        INTO TABLE @DATA(trs_in_system)
        UP TO 1 ROWS.

      IF trs_in_system IS INITIAL.
        APPEND VALUE #( %tky = transport_request->%tky
                      %state_area = 'VALIDATE_TRANSPORT_REQUEST'
                    ) TO reported-transportrequests.

        APPEND VALUE #( ) TO failed-transportrequests.

        APPEND VALUE #( %tky = transport_request->%tky
                          %state_area = 'VALIDATE_TRANSPORT_REQUEST'
                          %path = VALUE #( projects-%tky = trs_projects_link[ source-%tky = transport_request->%tky ]-target-%tky
                                           charms-%tky = trs_charms_link[ source-%tky = transport_request->%tky ]-target-%tky )
                          %msg = NEW zcm_demo_s4_how( textid = zcm_demo_s4_how=>transport_request_not_valid
                                                      severity = if_abap_behv_message=>severity-error
                                                      transport_request = transport_request->TransportRequest )
                          %element-transportrequest = if_abap_behv=>mk-on ) TO reported-transportrequests.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD setTransportRequestDescription.

    READ ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
      ENTITY TransportRequests
      FIELDS ( TransportRequest
               Description )
      WITH CORRESPONDING #( keys )
      RESULT DATA(transport_requests).

    LOOP AT transport_requests REFERENCE INTO DATA(transport_request).

      SELECT FROM zi_demo_tr_with_objects
        FIELDS
          TransportRequest,
          Description
        WHERE TransportRequest = @transport_request->TransportRequest
        ORDER BY TransportRequest
        INTO TABLE @DATA(trs_in_system)
        UP TO 1 ROWS.

      IF trs_in_system IS INITIAL.
        RETURN.
      ENDIF.

      IF line_exists( trs_in_system[ TransportRequest = transport_request->TransportRequest ] )
        AND trs_in_system[ TransportRequest = transport_request->TransportRequest ]-Description = transport_request->Description.
        RETURN.
      ENDIF.

      transport_request->Description = trs_in_system[ TransportRequest = transport_request->TransportRequest ]-Description.

      MODIFY ENTITIES OF zi_demo_s4_project_interface IN LOCAL MODE
        ENTITY TransportRequests
        UPDATE
          FIELDS ( Description )
        WITH CORRESPONDING #( transport_requests )
       REPORTED DATA(updated_reported).
    ENDLOOP.

    reported = CORRESPONDING #( DEEP updated_reported ).

  ENDMETHOD.

ENDCLASS.
