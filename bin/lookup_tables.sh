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
WorkflowType
Schedule
ScheduleComponent
Imager
Detector
DewarLocationList
BF_component
BF_subcomponent
BF_system
BLSampleImageAutoScoreSchema
BLSampleImageAutoScoreClass
SpaceGroup
ProcessingPipelineCategory
ProcessingPipeline
BLSampleType
PurificationColumn
UserGroup
Permission
UserGroup_has_Permission
ScanParametersService
)

LOOKUP_TABLES_STRING=''
for TABLE in "${LOOKUP_TABLES[@]}"
do :
    LOOKUP_TABLES_STRING+=" ${TABLE}"
done
