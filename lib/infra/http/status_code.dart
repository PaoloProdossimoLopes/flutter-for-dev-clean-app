
enum StatusCode {
    ok,
    badRequestError,
    noContentError,
    unauthorizedError,
    forbidenError,
    notFoundError,
    internalServerError,
    undefinedExpeception
}

extension StatusCodeHelper on StatusCode {
    static statusCode(int statusCode) {
        if (statusCode == 200) {
            return StatusCode.ok;
        } else if (statusCode == 204) {
            return StatusCode.noContentError;
        } else if (statusCode == 400) {
            return StatusCode.badRequestError;
        } else if (statusCode == 401) {
            return StatusCode.unauthorizedError;
        } else if (statusCode == 403) {
            return StatusCode.forbidenError;
        } else if (statusCode == 404) {
            return StatusCode.notFoundError;
        } else if (statusCode == 500) {
            return StatusCode.internalServerError;
        } else {
            return StatusCode.undefinedExpeception;
        }
    }
}