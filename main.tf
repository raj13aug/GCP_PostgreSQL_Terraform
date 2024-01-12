
resource "google_sql_database_instance" "primary" {
  name             = var.gcp_pg_name_primary
  database_version = var.gcp_pg_database_version
  region           = var.gcp_pg_region_primary

  settings {
    tier = var.gcp_pg_tier

    database_flags {
      name  = var.gcp_pg_db_flag_name
      value = var.gcp_pg_db_flag_value
    }
  }
}

resource "google_sql_database_instance" "secondary" {
  name             = var.gcp_pg_name_secondary
  database_version = var.gcp_pg_database_version
  region           = var.gcp_pg_region_secondary

  master_instance_name = google_sql_database_instance.primary.name

  settings {
    tier = var.gcp_pg_tier
    database_flags {
      name  = var.gcp_pg_db_flag_name
      value = var.gcp_pg_db_flag_value
    }
  }
}

output "instance_primary_ip_address" {
  value = google_sql_database_instance.primary.ip_address
}

output "instance_secondary_ip_address" {
  value = google_sql_database_instance.secondary.ip_address
}
