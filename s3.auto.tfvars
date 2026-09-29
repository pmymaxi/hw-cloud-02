storage_bucket = {
  hw-cloud-02-test-20260929 = {
    versioning = true

    anonymous_access = {
      read        = true
      list        = false
      config_read = false
    }

    objects = {
      test_file = {
        key    = "img/picture.jpg"
        source = "/image/picture.jpg"
        public = true

        tags = {
          bucket = "test-img-bucket"
        }
      }
    }
  }
}