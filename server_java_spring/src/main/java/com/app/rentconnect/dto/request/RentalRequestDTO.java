package com.app.rentconnect.dto.request;

import com.app.rentconnect.Constants;
import com.app.rentconnect.entity.BookingHistory;
import com.app.rentconnect.entity.Car;
import com.app.rentconnect.entity.User;
import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;

import java.time.LocalDateTime;
import java.util.List;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@JsonInclude(JsonInclude.Include.NON_NULL)

public class RentalRequestDTO {
    private List<BookingHistoryRequestDTO> bookingHistory;
    Long rentalId;
    CarRequestDTO car;
    UserRequestDTO customer;
    UserRequestDTO owner;
    LocalDateTime startDate;
    LocalDateTime endDate;
    Constants.RentalStatus status = Constants.RentalStatus.REQUESTED;
    LocalDateTime createdAt = LocalDateTime.now();
    LocalDateTime deletedAt;
}
