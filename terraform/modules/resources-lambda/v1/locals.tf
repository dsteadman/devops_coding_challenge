locals {
  # source_path   = var.source_path
  # path_include  = var.path_include
  # path_exclude  = var.path_exclude
  # files_include = setunion([for f in local.path_include : fileset(local.source_path, f)]...)
  # files_exclude = setunion([for f in local.path_exclude : fileset(local.source_path, f)]...)
  # files         = sort(setsubtract(local.files_include, local.files_exclude))

  # dir_sha = sha1(join("", [for f in local.files : filesha1("${local.source_path}/${f}")]))
}
