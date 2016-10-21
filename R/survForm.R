#' survForm
#'
#' Turns a survival object into a dataframe for ggplot
#'
#' @param srv A Surv class object.
#' @param X A factor or character vector on which the survival should be split.
#' @return A data.frame with columns for time, n.risk, n.event, n.censor, surv, lower and upper. (95% confidence intervals)
#' @export
#' @examples
#' srv <- Surv(c(rchisq(1000,3)*10,
#' rchisq(1000,5)*10),
#' c(rbinom(1000,1,.9),
#'   rbinom(1000,1,.9)))
#' X <- rep(c('A','B'),each=1000)
#' frm <- survForm(srv,X)
#' head(frm)

survForm <- function(srv,X=NULL){
  if(class(srv) != 'Surv') stop('srv is not a Survival object.')

  if(is.null(X)){
    s <- survival::survfit(srv~1)
    frm <- data.frame(time = c(0,s$time),
                      n.risk = c(s$n.risk[1],s$n.risk),
                      n.event = c(0,s$n.event),
                      n.censor = c(0,s$n.censor),
                      surv = c(1,s$surv),
                      lower = c(s$lower[1],s$lower),
                      upper = c(s$upper[1],s$upper))

    return(frm)
  }

  data.frame(srv= srv,X=X) %>%
    dplyr::group_by(X) %>%
    dplyr::do(s = survival::survfit(.$srv~1)) %>%
    dplyr::do(data.frame(
      Group = .$X,
      time = c(0,.$s$time),
      n.risk = c(.$s$n.risk[1],.$s$n.risk),
      n.event = c(0,.$s$n.event),
      n.censor = c(0,.$s$n.censor),
      surv = c(1,.$s$surv),
      lower = c(.$s$lower[1],.$s$lower),
      upper = c(.$s$upper[1],.$s$upper))) %>%
    as.data.frame()
}
