variable "JWT_SECRET" {
  type        = string
  description = "Long random string used to verify JWT tokens for user authentication"
}

variable "ADMIN_EMAIL" {
  type        = string
  description = "Credentials for the admin user created at app initialization"
}

variable "ADMIN_PASS" {
  type        = string
  description = "Credentials for the admin user created at app initialization"
}

variable "EMAIL_PASS" {
  type        = string
  description = "Password of email used to send verification, registration, and confirmation emails"
}

variable "DB_QUILL_USERNAME" {
  type        = string
  description = "Credentials for Quill to access MongoDB"
}

variable "DB_QUILL_PASSWORD" {
  type        = string
  description = "Credentials for Quill to access MongoDB"
}

variable "GITHUB_BRANCH" {
  type        = string
  description = "The branch to pull from Quill Repo on Github"
}
