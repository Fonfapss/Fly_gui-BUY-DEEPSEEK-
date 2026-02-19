package com.example.lanbroadcast;

import com.mojang.logging.LogUtils;
import org.slf4j.Logger;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.MulticastSocket;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.atomic.AtomicBoolean;

final class LanBroadcastService {
    private static final Logger LOGGER = LogUtils.getLogger();
    private static final InetSocketAddress LAN_MULTICAST = new InetSocketAddress("224.0.2.60", 4445);
    private static final long SEND_INTERVAL_MS = 1_500L;

    private final String motd;
    private final int port;
    private final AtomicBoolean running = new AtomicBoolean(false);
    private Thread thread;

    LanBroadcastService(final String motd, final int port) {
        this.motd = motd;
        this.port = port;
    }

    void start() {
        if (!running.compareAndSet(false, true)) {
            return;
        }

        thread = Thread.ofVirtual().name("lan-broadcast-thread").start(this::runLoop);
    }

    void stop() {
        if (!running.compareAndSet(true, false)) {
            return;
        }

        if (thread != null) {
            thread.interrupt();
        }
    }

    private void runLoop() {
        final String payload = "[MOTD]" + motd + "[/MOTD][AD]" + port + "[/AD]";
        final byte[] bytes = payload.getBytes(StandardCharsets.UTF_8);

        try (MulticastSocket socket = new MulticastSocket()) {
            socket.setTimeToLive(1);
            socket.setReuseAddress(true);

            final InetAddress group = LAN_MULTICAST.getAddress();
            final int targetPort = LAN_MULTICAST.getPort();

            while (running.get() && !Thread.currentThread().isInterrupted()) {
                final DatagramPacket packet = new DatagramPacket(bytes, bytes.length, group, targetPort);
                socket.send(packet);
                Thread.sleep(SEND_INTERVAL_MS);
            }
        } catch (InterruptedException ignored) {
            Thread.currentThread().interrupt();
        } catch (IOException e) {
            LOGGER.error("LAN broadcast loop failed", e);
        }
    }
}
