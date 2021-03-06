% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/email.R
\name{validate_email}
\alias{validate_email}
\title{Validate an email address on r-hub}
\usage{
validate_email(email = email_address(), token = NULL)
}
\arguments{
\item{email}{The email address to validate. If not specified,
\code{rhub} tries to find it, via \code{\link[whoami:email_address]{whoami::email_address()}}.}

\item{token}{Token obtained from \code{rhub}, to validate the email address.
If not specified, then a new token is requested, and will be sent
to the email address, and it can be specified interactively.}
}
\description{
To build and check R packages on r-hub, you need to validate your
email address. This is because r-hub sends out emails about build
results.
}

