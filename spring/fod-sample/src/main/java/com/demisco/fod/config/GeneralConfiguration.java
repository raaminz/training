package com.demisco.fod.config;

import com.demisco.fod.Class1;
import com.demisco.fod.IClass;
import com.ibm.icu.text.SimpleDateFormat;
import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.context.annotation.*;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.web.servlet.view.JstlView;

import java.util.Locale;

@Configuration
@EnableAspectJAutoProxy(proxyTargetClass = true)
@EnableJpaRepositories(basePackages = "com.demisco.fod.service.repository")
public class GeneralConfiguration {

    @Bean
    @Primary
    public SimpleDateFormat defaultDateFormat() {
        SimpleDateFormat simpleDateFormat =
                new SimpleDateFormat("yyyy/MM/dd");
        return simpleDateFormat;
    }

    @Bean
    public SimpleDateFormat persianDateFormat() {
        SimpleDateFormat simpleDateFormat =
                new SimpleDateFormat("yyyy/MM/dd"
                        , new Locale("fa", "IR"));
        return simpleDateFormat;
    }

 /*   @Bean
    public ProxyFactoryBean proxyFactoryBean(IClass class1) {
        ProxyFactoryBean proxyFactoryBean = new ProxyFactoryBean();
        proxyFactoryBean.setTarget(class1);
        proxyFactoryBean.setInterceptorNames("aroundMethodInterceptor");
        return proxyFactoryBean;
    }*/

}
