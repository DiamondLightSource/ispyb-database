LOOKUP_TABLES=(
AdminVar
SchemaStatus
ComponentType
ComponentSubType
ConcentrationType
ContainerType
ExperimentType
InspectionType
PlateType
SessionType
WorkflowType
Schedule
Imager
Detector
DewarLocationList
BeamLineSetup
BF_component
BF_subcomponent
BF_system
Permission
BLSampleImageAutoScoreSchema
BLSampleImageAutoScoreClass
SpaceGroup
ProcessingPipeline
ProcessingPipelineCategory
BLSampleType
PurificationColumn
)

LOOKUP_TABLES_STRING=''
for TABLE in "${LOOKUP_TABLES[@]}"
do :
    LOOKUP_TABLES_STRING+=" ${TABLE}"
done
