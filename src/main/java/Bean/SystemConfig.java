package Bean;

import org.springframework.stereotype.Service;

@Service
public class SystemConfig {

    // kieu he dieu hanh
    public static String os;

    // kiem tra trang thai ung dung chay lan dau hay lan thu 2
    public boolean statusRun = false;

    public SystemConfig() {
        if (System.getProperty("os.name").contains("Windows")) {
            os = "Windows";
        }
        if (System.getProperty("os.name").contains("Linux")) {
            os = "Linux";
        }
    }
}
