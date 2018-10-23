package com.demisco.fod;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import java.util.Arrays;

public class AroundMethodInterceptor implements MethodInterceptor {
    private static Log LOGGER = LogFactory.getLog("Logger-AOP");

    public Object invoke(MethodInvocation methodInvocation) throws Throwable {
        Object[] args = methodInvocation.getArguments();
        String signature = methodInvocation.getMethod().toString();

        Object result = methodInvocation.proceed();

        LOGGER.info(String.format(
                "Method %s has called from class %s with return value type %s",
                signature,
                methodInvocation.getThis().getClass().toString(),
                result.getClass().getName()));

        return result;
    }

}
