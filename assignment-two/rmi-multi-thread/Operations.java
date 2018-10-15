import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Operations extends Remote {
    double multiply() throws RemoteException;
}