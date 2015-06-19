module Common
  CLOUD_CONFIG_PATH = File.join(File.dirname(__FILE__), "user-data")

  # =======================================================
  # Configuration for Docker Mirror registry
  # See: https://github.com/YungSang/docker-registry-mirror
  # =======================================================
  DOCKER_REGISTRY_IP = "172.17.8.50"
  DOCKER_REGISTRY    = "dockermirror"
  DOCKER_REGISTRY_UI = "dockermirror-frontend"

  # ===================================
  # Configuration for CoreOS machines
  # ===================================
  BASE_IP="172.17.8."
  MASTER_BOX = {
    :name => "coremaster",
    :num_instances => 1,
    :cpus => 1,
    :memory => 1024, # In MB
    :ip_offset => 100,
    :script => "bootstrap-as-master"
  }
  WORKER_BOX = {
    :name => "coreworker",
    :num_instances => 1,
    :cpus => 1,
    :memory => 1024, # In MB
    :ip_offset => 150,
    :script => "bootstrap-as-worker"
  }

  def Common.get_ips(box)
    return (0..(box[:num_instances]-1)).to_a.map { |i| BASE_IP + (i + box[:ip_offset]).to_s }
  end
end
