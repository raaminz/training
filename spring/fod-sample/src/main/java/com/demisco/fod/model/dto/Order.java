package com.demisco.fod.model.dto;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Objects;

public class Order {
    private Long orderId;
    private String orderName;
    private String orderAddress;
    private Boolean shipped;

    @NotNull
    public Long getOrderId() {
        return orderId;
    }

    @NotNull
    @Size(min = 2, max = 10)
    public String getOrderName() {
        return orderName;
    }

    @NotNull
    @AssertTrue
    public Boolean getShipped() {
        return shipped;
    }

    public void setShipped(Boolean shipped) {
        this.shipped = shipped;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    public String getOrderAddress() {
        return orderAddress;
    }

    public void setOrderAddress(String orderAddress) {
        this.orderAddress = orderAddress;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return Objects.equals(orderId, order.orderId) &&
                Objects.equals(orderName, order.orderName) &&
                Objects.equals(orderAddress, order.orderAddress);
    }

    @Override
    public int hashCode() {

        return Objects.hash(orderId, orderName, orderAddress);
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", orderName='" + orderName + '\'' +
                ", orderAddress='" + orderAddress + '\'' +
                '}';
    }
}
