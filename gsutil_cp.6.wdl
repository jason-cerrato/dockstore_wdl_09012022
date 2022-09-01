version 1.0

task copy {
    input {
	   String copy_from_directory
       String copy_to_directory
       Int? num_cpu = 1
       Int? mem_gb = 2
       Int? disk_size = 10
       Int? num_preemptibles = 2
    }

	command {
      echo --------------; echo "Start - time: $(date)"; set -euxo pipefail; echo --------------

      gsutil -m rsync -r ${copy_from_directory}/* ${copy_to_directory}/

      echo --------------; set +xe; echo "Done - time: $(date)"; echo --------------
  	}

    runtime {
      docker: "gcr.io/google.com/cloudsdktool/cloud-sdk:305.0.0"
      cpu: "${num_cpu}"
      memory: "${mem_gb} GB"
      disks: "local-disk ${disk_size} HDD"
      preemptible: "${num_preemptibles}"
    }
}

workflow gsutilcp {
	call copy
}