data "template_file" "master" {
  template = "${file("cluster/master_node.yml.tpl")}"
  count = "${yandex_compute_instance.master.count}"
  vars {
    name   = "${element(yandex_compute_instance.master.*.name, count.index)}"
    user   = "${var.username}"
    int_ip = "${element(yandex_compute_instance.master.*.network_interface.0.ip_address, count.index)}"
    nat_ip = "${element(yandex_compute_instance.master.*.network_interface.0.nat_ip_address, count.index)}"
  }
}
data "template_file" "worker" {
  template = "${file("cluster/worker_node.yml.tpl")}"
  count = "${yandex_compute_instance.worker.count}"
  vars {
    name   = "${element(yandex_compute_instance.worker.*.name, count.index)}"
    user   = "${var.username}"
    int_ip = "${element(yandex_compute_instance.worker.*.network_interface.0.ip_address, count.index)}"
    nat_ip = "${element(yandex_compute_instance.worker.*.network_interface.0.nat_ip_address, count.index)}"
  }
}
data "template_file" "cluster-config" {
  template = "${file("cluster/cluster.yml.tpl")}"
  vars {
    cluster      = "${var.cluster_name}"
    private_key  = "${var.private_key_file}"
    master_nodes = "${join("\n", data.template_file.master.*.rendered)}"
    worker_nodes = "${join("\n", data.template_file.worker.*.rendered)}"
  }
}
output "cluster" {
  value = "${data.template_file.cluster-config.rendered}"
}
data "template_file" "config_file" {
  template = "${var.output_path}${var.cluster_name}.yml"
}
data "template_file" "kubeconfig_file" {
  template = "${var.output_path}kube_config_${var.cluster_name}.yml"
}
resource "null_resource" "cluster" {
  triggers {
    config = "${data.template_file.cluster-config.rendered}"
  }
  provisioner "local-exec" {
    command = "test -e ${var.output_path} || mkdir -p ${var.output_path}"
  }
  provisioner "local-exec" {
    command = "echo \"${data.template_file.cluster-config.rendered}\" > ${data.template_file.config_file.rendered}"
  }
  provisioner "local-exec" {
    command = "test -e ${var.private_key_file} || echo \"${tls_private_key.ssh-key.private_key_pem}\" > ${var.private_key_file} && chmod 400 ${var.private_key_file}"
  }
  provisioner "local-exec" {
    command = "test -e ${data.template_file.kubeconfig_file.rendered} && scripts/rke.sh ${data.template_file.config_file.rendered} up --update-only  || scripts/rke.sh ${data.template_file.config_file.rendered} up"
  }
}
output "kubeconfig" {
  value = "${data.template_file.kubeconfig_file.rendered}"
}