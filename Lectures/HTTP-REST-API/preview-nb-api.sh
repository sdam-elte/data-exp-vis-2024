#!/bin/bash

echo "API URL is at https://${SERVERNAME}/${REPORT_URL}"


poetry run jupyter-kernelgateway --KernelGatewayApp.port=$REPORT_PORT --KernelGatewayApp.api=notebook-http --KernelGatewayApp.ip=0.0.0.0 --KernelGatewayApp.allow_origin=* --KernelGatewayApp.seed_uri=$1 --KernelGatewayApp.base_url="/${REPORT_URL}/"
