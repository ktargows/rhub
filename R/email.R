
#' @export
#' @importFrom whoami email_address
#' @importFrom jsonlite unbox

validate_email <- function(email = email_address(), token = NULL) {

  assert_string(email)

  if (is.null(token) && !interactive()) {
    stop("No token and not in interactive mode")
  }

  if (is.null(token)) {
    query(
      "VALIDATE EMAIL",
      list(email = unbox(email))
    )

    message("Please check your emails for the R-hub access token")
    token <- readline(prompt = "token: ")
  }

  email_add_token(email, token)
  message("Token added for ", sQuote(email))

  invisible()
}

#' @importFrom rappdirs user_data_dir

email_file <- function() {
  rhub_data_dir <- user_data_dir("rhub", "rhub")
  file.path(rhub_data_dir, "validated_emails.csv")
}

email_get_token <- function(email) {
  file <- email_file()
  if (! file.exists(file)) stop(sQuote(email), " is not validated")

  tokens <- read.csv(file, stringsAsFactors = FALSE, header = FALSE)
  if (! email %in% tokens[,1]) stop(sQuote(email), " is not validated")

  tokens[match(email, tokens[,1]), 2]
}

## If it exists already, then overwrites

email_add_token <- function(email, token) {

  assert_string(email)
  assert_string(token)

  file <- email_file()

  if (!file.exists(file)) {
    parent <- dirname(file)
    if (!file.exists(parent)) dir.create(parent, recursive = TRUE)
    tokens <- data.frame(
      V1 = character(),
      V2 = character(),
      stringsAsFactors = FALSE
    )

  } else {
    tokens <- read.csv(file, stringsAsFactors = FALSE, header = FALSE)
  }

  if (! email %in% tokens[,1]) {
    tokens <- rbind(tokens, c(email, token))

  } else{
    tokens[match(email, tokens[,1]), 2] <- token
  }

  write.table(
    tokens,
    file = file,
    sep = ",",
    col.names = FALSE,
    row.names = FALSE
  )

  invisible()
}