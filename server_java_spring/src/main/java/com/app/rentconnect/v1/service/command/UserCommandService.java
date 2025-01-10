package com.app.rentconnect.v1.service.command;

import com.app.rentconnect.v1.dto.request.UserRequestDTO;
import com.app.rentconnect.v1.dto.user.response.UserResponseDTO;
import com.app.rentconnect.v1.entity.User;
import com.app.rentconnect.v1.mapper.UserMapper;
import com.app.rentconnect.v1.repository.UserRepository;
import com.cloudinary.utils.StringUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
@FieldDefaults(level= AccessLevel.PRIVATE, makeFinal = true)
public class UserCommandService {
    UserRepository userRepository;
    UserMapper userMapper;
    @PersistenceContext
    EntityManager entityManager;

    public User save(User user) {
        return userRepository.save(user);
    }
    public void verifyByEmail(String email,boolean isVerified) {
        userRepository.vertifyUserByEmail(email,isVerified);
    }

    public UserResponseDTO update(UserRequestDTO userRequestDTO) {
        User updateUser = userMapper.toEntity(userRequestDTO);
        Optional<User> currentUser = userRepository.findById(userRequestDTO.getUserId());
        if (currentUser.isPresent()) {
            User user = currentUser.get();

            if (!StringUtils.isEmpty(updateUser.getFullName())) {
                user.setFullName(updateUser.getFullName());
            }

            if (!StringUtils.isEmpty(updateUser.getEmail())) {
                user.setEmail(updateUser.getEmail());
            }

            if (!StringUtils.isEmpty(updateUser.getPhoneNumber())) {
                user.setPhoneNumber(updateUser.getPhoneNumber());
            }
            entityManager.merge(user);
            return userMapper.toResponseDTO(user);
        }
        else return null;
    }

    public void delete(Long userid) {
        userRepository.deleteById(userid);
    }
}
