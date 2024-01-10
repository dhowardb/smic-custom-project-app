@EndUserText.label: 'Abstract view for adding objects per TR'
@Metadata.allowExtensions: true
define abstract entity ZRK_ADD_TR_WITH_OBJECTS
  //  with parameters parameter_name : parameter_type
{
  @EndUserText.label: 'Transport Request'
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_TR_WITH_OBJECTS', element: 'TransportRequest' } }]
  @ObjectModel.mandatory: true
  addObjectsPerTR : trkorr;
  @EndUserText.label: 'Comment'
  comments        : abap.string( 256 );

}
