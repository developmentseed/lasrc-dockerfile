#!/bin/bash
stack=lasrc
cluster=$(aws cloudformation describe-stacks --stack-name "$stack" \
--query "Stacks[0].Outputs[?OutputKey=='ClusterName'].OutputValue" --output text)
echo "$cluster"
task=arn:aws:ecs:us-east-1:552819999234:task-definition/lasrc:3
granuletype=LANDSAT_SCENE_ID
granuleid=LC08_L1TP_027039_20190901_20190901_01_RT
command=/usr/local/lasrc_landsat_granule.sh
overrides=$(cat <<EOF 
{
  "containerOverrides": [
    {
      "name": "lasrc",
      "command": ["$command"],
      "environment": [
        {
          "name": "$granuletype",
          "value": "$granuleid"
        },
        { 
          "name": "LASRC_AUX_DIR",
          "value": "/var/lasrc_aux"
        }
      ]
    }
  ]
}
EOF
)
echo "$overrides" > ./overrides.json
aws ecs run-task --overrides file://overrides.json --task-definition "$task" \
  --cluster "$cluster" 
