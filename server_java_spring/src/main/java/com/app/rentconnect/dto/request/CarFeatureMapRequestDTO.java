package com.app.rentconnect.dto.request;

import com.app.rentconnect.dto.car.request.CarRequestDTO;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@JsonInclude(JsonInclude.Include.NON_NULL)

public class CarFeatureMapRequestDTO {
    Long id;
    CarRequestDTO car;
    CarFeatureRequestDTO feature;
    String featureValue;
}
