package com.fort4.service;

import com.fort4.dto.RentalRequestDTO;
import java.util.List;

public interface AdminRentalService {

    List<RentalRequestDTO> getAllRequests();

    boolean approveRequest(int requestId);

    boolean rejectRequest(int requestId);
}
