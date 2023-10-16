resource "shoreline_notebook" "high_jvm_heap_usage_in_elasticsearch" {
  name       = "high_jvm_heap_usage_in_elasticsearch"
  data       = file("${path.module}/data/high_jvm_heap_usage_in_elasticsearch.json")
  depends_on = [shoreline_action.invoke_update_elasticsearch_heap]
}

resource "shoreline_file" "update_elasticsearch_heap" {
  name             = "update_elasticsearch_heap"
  input_file       = "${path.module}/data/update_elasticsearch_heap.sh"
  md5              = filemd5("${path.module}/data/update_elasticsearch_heap.sh")
  description      = "Increase the heap size of the JVM allocated to Elasticsearch. This can be done by updating the JVM options in Elasticsearch's configuration file."
  destination_path = "/tmp/update_elasticsearch_heap.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_elasticsearch_heap" {
  name        = "invoke_update_elasticsearch_heap"
  description = "Increase the heap size of the JVM allocated to Elasticsearch. This can be done by updating the JVM options in Elasticsearch's configuration file."
  command     = "`chmod +x /tmp/update_elasticsearch_heap.sh && /tmp/update_elasticsearch_heap.sh`"
  params      = ["PATH_TO_ELASTIC_SEARCH_CONFIG_FILE","NEW_HEAP_SIZE"]
  file_deps   = ["update_elasticsearch_heap"]
  enabled     = true
  depends_on  = [shoreline_file.update_elasticsearch_heap]
}

