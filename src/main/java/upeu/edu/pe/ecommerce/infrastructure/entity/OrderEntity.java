/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package upeu.edu.pe.ecommerce.infrastructure.entity;

import jakarta.persistence.*;
import java.math.BigDecimal; // <-- ¡IMPORTACIÓN NECESARIA Y CORRECTA!
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "orders")
public class OrderEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private LocalDateTime dateCreated;
    private String status;
    
    // --- LÍNEA CORREGIDA ---
    // private String total; // <-- LÍNEA ORIGINAL INCORRECTA
    @Column(precision = 10, scale = 2) // Buena práctica para definir el tipo DECIMAL en la DB
    private BigDecimal total; // <-- LÍNEA CORREGIDA
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity userEntity;
    
    @OneToMany(mappedBy = "orderEntity", cascade = CascadeType.PERSIST) // <-- CORRECCIÓN ADICIONAL
    private List<OrderProductEntity> orderProducts;
    
    public OrderEntity() {
    }
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public LocalDateTime getDateCreated() {
        return dateCreated;
    }
    
    public void setDateCreated(LocalDateTime dateCreated) {
        this.dateCreated = dateCreated;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    // --- MÉTODOS GETTER Y SETTER CORREGIDOS ---
    public BigDecimal getTotal() {
        return total;
    }
    
    public void setTotal(BigDecimal total) {
        this.total = total;
    }
    
    public UserEntity getUserEntity() {
        return userEntity;
    }
    
    public void setUserEntity(UserEntity userEntity) {
        this.userEntity = userEntity;
    }
    
    public List<OrderProductEntity> getOrderProducts() {
        return orderProducts;
    }
    
    public void setOrderProducts(List<OrderProductEntity> orderProducts) {
        this.orderProducts = orderProducts;
    }
    
    public void addOrderProduct(List<OrderProductEntity> orderProducts) {
        this.setOrderProducts(orderProducts);
    }
    
    public BigDecimal getTotalOrderPrice(){
        // Este método ya estaba bien, porque usaba BigDecimal.
        // Ahora es consistente con el campo 'total'.
        return getOrderProducts().stream().map(p->p.getTotalPrice()
        ).reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}
