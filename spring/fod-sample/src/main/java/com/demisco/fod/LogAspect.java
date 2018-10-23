package com.demisco.fod;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LogAspect {
    @Pointcut("execution(public * com.demisco.fod.*.*(..))")
    public void allMethods() {
    }

    @Pointcut("@annotation(com.demisco.fod.Log)")
    public void withLogAnnotation() {

    }

    @Around("allMethods() && withLogAnnotation()")
    public Object logAround(ProceedingJoinPoint joinPoint) throws Throwable {
        LOGGER.info(String.format(
                "Method %s is going to Call from class %s",
                joinPoint.getSignature().toString(),
                joinPoint.getThis().getClass().getSimpleName()));

        Object returnObj = joinPoint.proceed(joinPoint.getArgs());

        LOGGER.info(String.format(
                "Method %s has called from class %s with return value type %s",
                joinPoint.getSignature().toString(),
                joinPoint.getThis().getClass().getSimpleName(),
                returnObj.getClass().getName()));

        return returnObj;
    }

    private static Log LOGGER = LogFactory.getLog(LogAspect.class.getName());
}
