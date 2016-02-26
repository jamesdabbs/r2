S3DirectUpload.config do |c|
  c.access_key_id     = Figaro.env.S3_ACCESS_KEY_ID!
  c.secret_access_key = Figaro.env.S3_SECRET_ACCESS_KEY!
  c.bucket            = Figaro.env.S3_BUCKET!
end
