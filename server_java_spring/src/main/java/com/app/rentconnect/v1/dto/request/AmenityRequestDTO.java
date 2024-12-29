package com.app.rentconnect.v1.dto.request;
import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@JsonInclude(JsonInclude.Include.NON_NULL)

public class AmenityRequestDTO {
    private List<CarAmenityRequestDTO> carAmenities;
    Long amenityId;
    String amenityName;
    String icon;
    LocalDateTime deletedAt;
}