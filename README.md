
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# "High JVM Heap Usage in Elasticsearch"
---

This incident type refers to situations where the percentage of the Java Virtual Machine (JVM) heap being used by Elasticsearch exceeds a certain threshold. The JVM heap is a portion of memory allocated to the JVM for running the Elasticsearch application, and if it becomes too full, it can cause the system to slow down or crash. This incident often requires investigation to identify the root cause of the high heap usage and may involve adjusting configuration settings or optimizing the Elasticsearch environment to prevent similar incidents from occurring in the future.

### Parameters
```shell
export ELASTICSEARCH_CLUSTER_URL="PLACEHOLDER"

export ELASTICSEARCH_NODE_URL="PLACEHOLDER"

export ELASTICSEARCH_LOG_FILE_PATH="PLACEHOLDER"

export PATH_TO_ELASTIC_SEARCH_CONFIG_FILE="PLACEHOLDER"

export NEW_HEAP_SIZE="PLACEHOLDER"
```

## Debug

### Check Elasticsearch cluster health
```shell
curl -XGET ${ELASTICSEARCH_CLUSTER_URL}/_cluster/health
```

### Check Elasticsearch node stats
```shell
curl -XGET ${ELASTICSEARCH_NODE_URL}/_nodes/stats/jvm
```

### Check Elasticsearch JVM heap usage
```shell
curl -XGET ${ELASTICSEARCH_NODE_URL}/_nodes/stats/jvm?filter_path=nodes.*.jvm.mem.heap_used_percent
```

### Check Elasticsearch JVM heap size
```shell
curl -XGET ${ELASTICSEARCH_NODE_URL}/_nodes/stats/jvm?filter_path=nodes.*.jvm.mem.heap_max_in_bytes
```

### Check Elasticsearch logs for any error messages related to high JVM heap usage
```shell
tail -n 1000 ${ELASTICSEARCH_LOG_FILE_PATH} | grep -i "heap"
```

## Repair

### Increase the heap size of the JVM allocated to Elasticsearch. This can be done by updating the JVM options in Elasticsearch's configuration file.
```shell


#!/bin/bash



# Set the Elasticsearch configuration file path

conf_file="${PATH_TO_ELASTIC_SEARCH_CONFIG_FILE}"



# Set the new heap size

new_heap_size="${NEW_HEAP_SIZE}"



# Update the JVM options in the Elasticsearch configuration file

sed -i "s/-Xmx[0-9]*[mMgG]/-Xmx$new_heap_size/g" $conf_file



# Restart Elasticsearch

systemctl restart elasticsearch.service


```