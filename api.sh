
API_DEV_NAME=$IP_ADDRESS
API_DEV_URL=$LIBRENMS_URL/api/v0/devices/$API_DEV_NAME

api_dev_exists() {
    STATUS=$(curl -LI $API_DEV_URL -o /dev/null -w '%{http_code}\n' -s)

    if [ STATUS == "200" ]; then 
        EXISTS="true"
    else if [ STATUS == "401" ]; then
        echo "Invalid API key"
        exit 1
    else 
        EXISTS="false"
    fi
}

api_add_device() {
    api_dev_exists
    if [ $EXISTS == "false" ]; then
        curl -X POST -d '{"hostname":"'"$IP_ADDRESS"'","version":"v2c","community":"public", "display":"'"$HOSTNAME"'"}' -H "X-Auth-Token: $TOKEN" $API_DEV_URL
        set_dev_type
        set_icon
    fi
}

api_set_dev_type() {
    curl -X PATCH -d '{"field": "type", "data": "network"}' -H "X-Auth-Token: $TOKEN" $API_DEV_URL
}

api_set_icon() {
    curl -X PATCH -d '{"field": "icon", "data": "images\/os\/ubiquiti.svg"}' -H "X-Auth-Token: $TOKEN" $API_DEV_URL
}

api_del_device() {
    curl -X DELETE -H "X-Auth-Token: $TOKEN" $API_DEV_URL
}

