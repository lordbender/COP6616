import java.rmi.Remote;
import java.rmi.RemoteException;

public interface IOperations extends Remote {
    double returnFirst(int size) throws RemoteException;
    double search(int size) throws RemoteException;
    double bubble(int size) throws RemoteException;
    double multiply(int size) throws RemoteException;
}