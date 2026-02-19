package com.example.lanbroadcast;

import com.mojang.logging.LogUtils;
import net.neoforged.api.distmarker.Dist;
import net.neoforged.bus.api.SubscribeEvent;
import net.neoforged.fml.common.EventBusSubscriber;
import net.neoforged.fml.common.Mod;
import net.neoforged.neoforge.event.server.ServerStartedEvent;
import net.neoforged.neoforge.event.server.ServerStoppingEvent;
import org.slf4j.Logger;

@Mod(LanBroadcastMod.MOD_ID)
@EventBusSubscriber(modid = LanBroadcastMod.MOD_ID, bus = EventBusSubscriber.Bus.GAME, value = Dist.DEDICATED_SERVER)
public final class LanBroadcastMod {
    public static final String MOD_ID = "lanbroadcast";
    private static final Logger LOGGER = LogUtils.getLogger();
    private static LanBroadcastService broadcaster;

    public LanBroadcastMod() {
        LOGGER.info("{} initialized", MOD_ID);
    }

    @SubscribeEvent
    public static void onServerStarted(final ServerStartedEvent event) {
        stopExisting();

        final var server = event.getServer();
        final String motd = server.getMotd();
        final int port = server.getPort();

        broadcaster = new LanBroadcastService(motd, port);
        broadcaster.start();

        LOGGER.info("Started LAN broadcast thread with MOTD '{}' on port {}", motd, port);
    }

    @SubscribeEvent
    public static void onServerStopping(final ServerStoppingEvent event) {
        stopExisting();
    }

    private static void stopExisting() {
        if (broadcaster != null) {
            broadcaster.stop();
            broadcaster = null;
            LOGGER.info("Stopped LAN broadcast thread");
        }
    }
}
