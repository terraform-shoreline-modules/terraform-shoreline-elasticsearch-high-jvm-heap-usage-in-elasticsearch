

#!/bin/bash



# Set the Elasticsearch configuration file path

conf_file="${PATH_TO_ELASTIC_SEARCH_CONFIG_FILE}"



# Set the new heap size

new_heap_size="${NEW_HEAP_SIZE}"



# Update the JVM options in the Elasticsearch configuration file

sed -i "s/-Xmx[0-9]*[mMgG]/-Xmx$new_heap_size/g" $conf_file



# Restart Elasticsearch

systemctl restart elasticsearch.service