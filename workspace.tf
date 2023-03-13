resource "azurerm_databricks_workspace" "demodb" {
    name = "mddatabrickdemo"
    location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    sku = "premimum"
}

resource "databricks_cluster" "cluster" {
    cluster_name = "mdcluster"
    spark_version = "7.3.x-scala2.12"
    node_type_id = "Standard_DS3_v2"
    autotermination_minutes = 90

    autoscale {
      min_workers = 1
      max_workers = 4
    }
    custom_tags = {
      Department = "Data Science"
    }

  
}
resource "databricks_notebook" "book" {
  content_base64 = base64encode("print('hello')")
  path = "/retrivebook"
  language = "PYTHON"
}
resource "databricks_job" "job" {
  name = "Import Job"
  timeout_seconds = 3600
  max_retries = 1
  max_concurrent_runs = 1
  job_cluster {
    job_cluster_key = "j"
    new_cluster {
      num_workers = 1
      spark_version = "7.3.x-scala2.12"
      node_type_id = "Standard_DS3_v2"
    } 
  }
  task {
    task_key = "task1"
    new_cluster {
      num_workers = 1
      spark_version = "7.3.x-scala2.12"
      node_type_id = "Standard_DS3_v2"
    }
    notebook_task {
      notebook_path = databricks_notebook.book.path
    }
    
  }
}




